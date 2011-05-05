class CreateRazas < ActiveRecord::Migration
  def self.up
    create_table :razas do |t|
      t.string :nombre
      t.integer :tipo

      t.timestamps
    end
    
    execute "ALTER TABLE razas ADD CONSTRAINT razas_unique_tipo
              UNIQUE(nombre, tipo)"
  end

  def self.down
    drop_table :razas
  end
end
