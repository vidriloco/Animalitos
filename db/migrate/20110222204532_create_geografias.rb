class CreateGeografias < ActiveRecord::Migration
  def self.up
    create_table :geografias do |t|
      t.point :coordenada, :srid => 4326, :with_z => false
      t.timestamps
    end
  end

  def self.down
    drop_table :geografias
  end
end
