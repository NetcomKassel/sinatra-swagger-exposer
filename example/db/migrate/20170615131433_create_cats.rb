class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.boolean :fluffy
      t.timestamps
    end
  end
end
