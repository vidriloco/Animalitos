module FotosHelper
  def es_foto_principal_de?(animal, foto)
    return animal.foto_id.nil?
    animal.foto_id == foto.id
  end
end