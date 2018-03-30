require_relative("../db/sql_runner.rb")

class Animal

  attr_reader :id
  attr_accessor :name, :breed, :status, :owner_id, :admission_date

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @breed = options['breed']
    @status = options['status']
    @owner_id = options['owner_id']
    @admission_date = options['admission_date']
  end



end
