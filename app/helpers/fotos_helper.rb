module FotosHelper
  def es_foto_principal_de?(animal, foto)
    animal.foto_id == foto.id
  end
end