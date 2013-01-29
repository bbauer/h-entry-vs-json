## Create Your DB

Use Postgres...or another DB if you want more work for yourself (like Don).

createdb -O[your_username] -Eutf8 [your_app_name]

## Change the obvious things in app.rb

specifically...

```ruby
set :database
```

## Run it

```ruby
ruby app.rb
```

### Data

You can see json data at...

/json/tasks

You can see hentry data at...

/hentry/tasks

Most of all though, you can see what happens...and where at app.rb
