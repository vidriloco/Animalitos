class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :telefono_movil, :cuenta_en_twitter, :bio, :es_admin
  
  validates_presence_of :email, :nombre
  validates_presence_of :password, :password_confirmation, :on => :create
  validates_uniqueness_of :email
  validates_format_of :cuenta_en_twitter, :with => /^@([A-Za-z0-9_]+)/, :unless => Proc.new { |usuario| usuario.cuenta_en_twitter.blank?  }
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
