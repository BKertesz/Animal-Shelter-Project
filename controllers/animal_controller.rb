require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal')
require_relative('../models/owner')
require('pry')

get '/animals' do
  if params['sort_by']
    @animals = Animal.find_all_by(params['sort_by'])
  else
    @animals = Animal.all
  end
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

get '/animals/adopt' do
  @owners = Owner.all
  @animals = Animal.find_all_by('Adoptable')
  erb(:'animals/adopt')
end

post '/animals/adopt' do
  animal = Animal.find_by_id(params['id'])
  animal.owner_id = params['owner_id']
  animal.location = 'Owner'
  animal.status = 'Adopted'
  animal.update
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
