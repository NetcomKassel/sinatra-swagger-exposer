class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name, null: false, limit: 2048
      t.string :photoUrls
      t.string :tags
      t.string :status
      t.timestamps
    end
  end
end
