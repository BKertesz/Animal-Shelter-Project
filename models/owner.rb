require_relative("../db/sql_runner.rb")
require_relative("animal")

class Owner

  attr_reader :id
  attr_accessor :name, :notes, :phone_number

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
    @notes = options['notes']
    @phone_number = options['phone_number']
  end

  def save()
    sql = "INSERT INTO owners (name,notes,phone_number) VALUES ($1,$2,$3) RETURNING id;"
    values = [@name,@notes,@phone_number]
    result = SqlRunner.run(sql,values)
    @id = result.first()['id'].to_i
  end

  def update()
    sql = "UPDATE owners SET name = $1,notes=$2,phone_number=$4 WHERE id=$3"
    values = [@name,@notes,@id,@phone_number]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE * FROM owners WHERE id=$1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def animals()
    sql = "SELECT * FROM animals WHERE owner_id=$1"
    values = [@id]
    result =  SqlRunner.run(sql,values)
    animals = result.map{|x| Animal.new(x)}
    return animals
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM owners WHERE id=$1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM owners"
    result = SqlRunner.run(sql)
    return result.map{|x| Owner.new(x)}
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM owners WHERE id=$1'
    values = [id]
    result = SqlRunner.run(sql,values)
    return Owner.new(result.first)
  end

  def self.delete_all()
    sql = 'DELETE FROM owners'
    SqlRunner.run(sql)
  end

end
