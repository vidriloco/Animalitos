class Foto < ActiveRecord::Base
  mount_uploader :carrierwave, FotoUploader
  belongs_to :animal
  
  validates_presence_of :descripcion
  validates_presence_of :carrierwave
  
  def asocia_carrierwave(archivo)
    if archivo
      self.mime_type = archivo.content_type
      self.carrierwave = archivo
      self.save
    else
      false
    end
  end
end
