class CreateAnimales < ActiveRecord::Migration
  def self.up
    create_table :animales do |t|
      t.string :nombre
      t.integer :raza_id
      t.text :descripcion
      t.integer :usuario_id
      t.point :coordenadas, :srid => 4326, :with_z => false      
      t.integer :estancia_temporal
      t.boolean :en_casa, :default => :false
      t.datetime :fecha
      t.integer :foto_id
      t.integer :situacion
      t.boolean :tiene_placa, :default => :false
      t.timestamps
    end
  end

  def self.down
    drop_table :animales
  end
end
