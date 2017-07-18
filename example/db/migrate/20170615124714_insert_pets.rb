require_relative '../../app/models/pet'

class InsertPets < ActiveRecord::Migration[5.1]
  def up
    Pet.create! name: 'doggie'
  end

  def down
    Pet.destroy_all
  end
end
