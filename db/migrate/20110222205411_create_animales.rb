class CreateAnimales < ActiveRecord::Migration
  def self.up
    create_table :animales do |t|
      t.string :nombre
      t.integer :raza_id
      t.text :descripcion
      t.integer :usuario_id
      t.integer :geografia_id
      t.boolean :en_casa
      t.datetime :fecha
      t.integer :foto_id
      t.integer :situacion
      t.timestamps
    end
  end

  def self.down
    drop_table :animales
  end
end
