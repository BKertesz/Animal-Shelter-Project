require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal')
require_relative('../models/owner')
require('pry')

get '/animals' do
  @animals = Animal.all
  erb(:"animals/index")
end

get '/animals/new' do
  @owners = Owner.all
  erb(:"animals/new")
end

post '/animals' do
  animal = Animal.new(params)
  animal.save
  redirect to '/animals'
end

get '/animals/search' do
  @search = params['name']
  @list = Animal.find_by_name(params['name'])
  erb(:'animals/search')
end

get '/animals/:id' do
  @animal = Animal.find_by_id(params['id'].to_i)
  erb(:'animals/show')
end

get '/animals/:id/edit' do
  @owners = Owner.all
  @animal = Animal.find_by_id(params['id'].to_i)
  @animal.update
  erb(:'animals/edit')
end

post '/animals/:id' do
  animal = Animal.new(params)
  animal.update
  redirect to ('/animals')
end

post '/animals/:id/delete' do
  Animal.delete_by_id(params['id'].to_i)
  redirect to ('/animals')
end


# EOF
