require 'spec_helper'

describe "H-Entry vs JSON App" do
  describe "GET '/'" do
    it "responds with success" do
      get '/'

      last_response.should be_ok
      assigns(:tasks).should eq(Task.all)
    end
  end

  describe "GET '/json/tasks'" do
    it "responds with all tasks as json" do
      get '/json/tasks'

      last_response.should be_ok
      last_response.body.should eql(Task.all.to_json)
    end
  end

  describe "GET '/json/tasks/1'" do
    it "responds with the given task as json" do
      get '/json/tasks/1'

      last_response.should be_ok
      last_response.body.should eql(Task.find(1).to_json)
    end
  end
end
