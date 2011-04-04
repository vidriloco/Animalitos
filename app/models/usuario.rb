class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :telefono_movil, :es_admin
  
  validates_presence_of :email, :nombre, :password, :password_confirmation
  validates_uniqueness_of :email
  
  has_many :animales, :dependent => :destroy
  
  def es_admin?
    es_admin
  end
  
  def unconfirm!
    confirmed_at = nil
    confirmation_token = nil
    save(:validate => false)
  end
end
