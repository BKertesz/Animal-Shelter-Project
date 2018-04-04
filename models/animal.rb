require_relative("../db/sql_runner.rb")

class Animal

  attr_reader :id
  attr_accessor :name, :breed, :status, :owner_id, :admission_date, :age, :gender, :description, :location

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @breed = options['breed']
    @age = options['age']
    @status = options['status']
    @owner_id = options['owner_id'].to_i if options['owner_id']
    @admission_date = options['admission_date']
    @description = options['description']
    @gender = options['gender']
    @location = options['location']
  end

  def save()
    sql = "INSERT INTO animals (name,breed,age,status,owner_id,admission_date,description,gender,location) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING id;"
    values = [@name,@breed,@age,@status,@owner_id,@admission_date,@description,@gender,@location]
    result = SqlRunner.run(sql,values)
    @id = result.first()['id'].to_i
  end

  def update()
    sql = "UPDATE animals SET name=$1, breed=$2, status=$3, owner_id=$4, admission_date=$5, age=$7, description=$8, gender=$9,location=$10 WHERE id=$6"
    values = [@name,@breed,@status,@owner_id,@admission_date,@id,@age,@description,@gender,@location]
    SqlRunner.run(sql,values)
  end

  def owner()
    return '' if !@owner_id
    sql = "SELECT * FROM owners WHERE id=$1"
    values = [@owner_id]
    result = SqlRunner.run(sql,values)
    my_array = result.map{|x| Owner.new(x)}
    owner =  my_array.first
    return owner.name
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM animals WHERE id=$1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM animals"
    result = SqlRunner.run(sql)
    return result.map{|x| Animal.new(x)}
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM animals WHERE id=$1'
    values = [id]
    result = SqlRunner.run(sql,values)
    return Animal.new(result.first)
  end

  def self.delete_all()
    sql = 'DELETE FROM animals'
    SqlRunner.run(sql)
  end

  def self.find_by_name(name)
    sql = 'SELECT * FROM animals WHERE name=$1'
    values = [name]
    result = SqlRunner.run(sql,values)
    my_array = result.map{|x| Animal.new(x)}
    return my_array
  end

  def self.find_all_by(option)
    sql = 'SELECT * FROM animals WHERE status=$1'
    values = [option]
    result = SqlRunner.run(sql,values)
    return result.map{|x| Animal.new(x)}
  end

end
