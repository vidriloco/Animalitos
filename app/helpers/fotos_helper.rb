module FotosHelper
  def es_foto_principal_de?(animal, foto)
    return false if animal.foto_id.nil?
    true if animal.foto_id == foto.id
  end
end