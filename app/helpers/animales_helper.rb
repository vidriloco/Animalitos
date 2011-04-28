module AnimalesHelper
  def ubicacion_y_fecha_animalito(animal)
    "#{animal.situacion_humanize} hace #{ time_ago_in_words(animal.fecha) }"
  end
  
  def despliega_resultado_de_busqueda(hash)
    return nil if hash.nil?
    nombre = "<span class='extraviado-nombre'>#{hash["nombre"]}</span>"
    "Resultados de #{mascota_tipo(hash)}#{situacion(hash["situacion"])} con nombre #{nombre}".html_safe
  end
  
  def situacion(numero, card=:p)
    situacion = numero == 1 ? " encontrado" : " extraviado"
    return situacion.pluralize if (card == :p)
    situacion 
  end
  
  def mascota_tipo(hash, card=:p) 
    tipo=hash["perro"] ? "perrito" : "gatito"
    return tipo.pluralize if (card == :p)
    tipo
  end
end
