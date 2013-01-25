%w[rubygems sinatra json sinatra/activerecord hentry_consumer httparty].each do |gem|
  require "#{gem}"
end

ActiveRecord::Base.include_root_in_json = false

set :database, 'postgres://brianbauer@localhost/h-entry-vs-json'

class Task < ActiveRecord::Base; end

get '/' do
  @tasks = Task.all

  erb :index
end

##
# JSON
#
get '/json/tasks' do
  content_type :json

  Task.all.to_json
end

get '/json/tasks/:id' do
  content_type :json

  Task.find(params[:id]).to_json
end

get '/json/parsed/tasks' do
  @tasks = HTTParty.get("http://localhost:4567/json/tasks").parsed_response

  erb :json_parsed
end

get '/json/parsed/tasks/:id' do
  @task = HTTParty.get("http://localhost:4567/json/tasks/#{params[:id]}").parsed_response

  erb :json_parsed_task
end

##
# HENTRY
#
get '/hentry/tasks' do
  @tasks = Task.all

  erb :hentries
end

get '/hentry/tasks/:id' do
  @task = Task.find(params[:id])

  erb :hentry
end

get '/hentry/parsed/tasks' do
  @tasks = HentryConsumer.parse("http://localhost:4567/hentry/tasks").entries

  erb :hentries_parsed
end

get '/hentry/parsed/tasks/:id' do
  @task = HentryConsumer.parse("http://localhost:4567/hentry/tasks/#{params[:id]}").entries.first

  erb :hentry_parsed_task
end
