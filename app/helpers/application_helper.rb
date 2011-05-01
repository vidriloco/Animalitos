module ApplicationHelper
  def info_de coleccion, objeto_nombre
    objeto_nombre = objeto_nombre.to_s
    
    return "" if coleccion.empty?
    @pluralizado = objeto_nombre.pluralize if coleccion.size != 1
    return "Encontrados #{coleccion.size} #{@pluralizado || objeto_nombre}"
  end
  
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] ||
    (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))

    if collection.total_pages < 2
      case collection.size
        when 0; "No se encontraron #{entry_name.pluralize}"
        when 1; "Mostrando <b>1</b> #{entry_name}"
        else; "Mostrando <b>#{collection.size}</b> #{entry_name.pluralize} <b>(todos)</b>"
      end
    else
      %{Mostrando #{entry_name.pluralize} <b>%d&nbsp;-&nbsp;%d</b> de <b>%d</b>} % [
      collection.offset + 1,
      collection.offset + collection.length,
      collection.total_entries
      ]
    end
  end
  
  def ubicacion_y_fecha_animalito(animal)
    "#{animal.situacion_humanize} hace #{ time_ago_in_words(animal.fecha) }"
  end
end
