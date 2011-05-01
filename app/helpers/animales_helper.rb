#encoding: utf-8
module AnimalesHelper
  
  def despliega_resultado_de_busqueda(hash)
    return nil if hash.nil?
    nombre = "<span class='extraviado-nombre'>#{hash["nombre"]}</span>"
    "Resultados de #{mascota_tipo(hash)}#{situacion(hash["situacion"])} con nombre #{nombre}".html_safe
  end
  
  def situacion(numero, card=:p)
    situacion = numero == Animal.encontrado ? " encontrado" : " extraviado"
    return situacion.pluralize if (card == :p)
    situacion 
  end
  
  def mascota_tipo(hash, card=:p) 
    tipo=hash["perro"] ? "perrito" : "gatito"
    return tipo.pluralize if (card == :p)
    tipo
  end
  
  def situacion_numeros(numero=0, situacion)
    if situacion==Animal.encontrado
      return "No hay ninguna mascota en adopción o encontrada" if numero == 0 
      "#{numero} en adopción o #{ numero == 1 ? 'encontrada' : 'encontradas' }"
    elsif situacion==Animal.extraviado
      return "Sin reportes de mascotas extraviadas" if numero == 0 
      "#{numero} #{numero == 1 ? 'reportada' : 'reportadas'} como #{ numero == 1 ? 'extraviada' : 'extraviadas' }"
    end
  end
end
