require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/owner')

get "/owners" do
  @owners = Owner.all()
  erb(:"owners/index")
end

get '/owners/new' do
  erb(:"owners/new")
end

post '/owners' do
  owner = Owner.new(params)
  owner.save
  redirect to '/owners'
end


get '/owners/:id' do
  @owner = Owner.find_by_id(params['id'].to_i)
  erb(:'owners/show')
end

get '/owners/:id/edit' do
  @owner = Owner.find_by_id(params['id'].to_i)
  @owner.update
  erb(:'owners/edit')
end

post '/owners/:id' do
  owner = Owner.new(params)
  owner.update
  redirect to ('/owners')
end

post '/owners/:id/delete' do
  Owner.delete_by_id(params['id'])
  # owner = Owner.new(params)
  # owner.delete
  redirect to ('/owners')
end
# eof
