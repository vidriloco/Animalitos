class Foto < ActiveRecord::Base
  mount_uploader :carrierwave, FotoUploader
  belongs_to :animal
  
  validates_presence_of :descripcion
  validates_presence_of :carrierwave
end
