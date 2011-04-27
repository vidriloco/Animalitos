module AnimalesHelper
  def ubicacion_y_fecha_animalito(animal)
    "#{animal.situacion_humanize} hace #{ time_ago_in_words(animal.fecha) }"
  end
end
