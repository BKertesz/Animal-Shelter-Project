require_relative("../models/animal")
require_relative("../models/owner")
require_relative("sql_runner")
require("pg")
require("pry")

Owner.delete_all
Animal.delete_all

owner1 = Owner.new({'name'=>'John Smith'})
owner2 = Owner.new({'name'=>'Rosa Palmer'})

owner1.save
owner2.save

animal1 = Animal.new({'name'=>'McCat','breed'=>'cat','status'=>'ready to adopt','owner_id'=>owner1.id,'admission_date'=>'09/02/1992','age' = '3'})
animal1.save



# EOF
