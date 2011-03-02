class CreateRazas < ActiveRecord::Migration
  def self.up
    create_table :razas do |t|
      t.string :nombre
      t.integer :tipo

      t.timestamps
    end
  end

  def self.down
    drop_table :razas
  end
end
