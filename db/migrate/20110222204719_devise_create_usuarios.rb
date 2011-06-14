class DeviseCreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table(:usuarios) do |t|
      
      t.string :nombre
      t.string :bio, :limit => 140
      t.boolean :es_admin
      t.integer :telefono_movil, :limit => 8
      t.string :cuenta_en_twitter
      
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end
    
    add_index :usuarios, :email,                :unique => true
    add_index :usuarios, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :usuarios
  end
end
