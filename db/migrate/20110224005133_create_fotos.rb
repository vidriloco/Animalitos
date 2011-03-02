class CreateFotos < ActiveRecord::Migration
  def self.up
    create_table :fotos do |t|
      t.text :descripcion
      t.string :mime_type
      t.integer :animal_id
      t.string :carrierwave
      
      t.timestamps
    end
  end

  def self.down
    drop_table :fotos
  end
end
