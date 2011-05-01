# encoding: utf-8

imgs="public/images/test/"

Factory.define :foto_de_perfil, :class => Foto do |t|
  t.descripcion "Foto de perfil"
  t.mime_type "image/jpg"
  t.after_build do |foto| 
    file = File.open(File.join(Rails.root, "#{imgs}beagle.jpg"))
    foto.asocia_carrierwave ActionDispatch::Http::UploadedFile.new(:filename => "beagle.jpg", :type => "image/jpg", :tempfile => file) 
  end
end

Factory.define :foto_de_frente, :class => Foto do |t|
  t.descripcion "Foto de frente"
  t.mime_type "image/jpg"
  t.after_build do |foto| 
    file = File.open(File.join(Rails.root, "#{imgs}beagle.jpg"))
    foto.asocia_carrierwave ActionDispatch::Http::UploadedFile.new(:filename => "beagle.jpg", :type => "image/jpg", :tempfile => file) 
  end
end

Factory.define :foto_de_akita, :class => Foto do |t|
  t.descripcion "Foto de akita"
  t.mime_type "image/jpg"
  t.after_build do |foto| 
    file = File.open(File.join(Rails.root, "#{imgs}akita.jpg"))
    foto.asocia_carrierwave ActionDispatch::Http::UploadedFile.new(:filename => "akita.jpg", :type => "image/jpg", :tempfile => file) 
  end
end

Factory.define :foto_de_lanudo, :class => Foto do |t|
  t.descripcion "Foto de lanudo"
  t.mime_type "image/jpg"
  t.after_build do |foto| 
    file = File.open(File.join(Rails.root, "#{imgs}lanudo.jpg"))
    foto.asocia_carrierwave ActionDispatch::Http::UploadedFile.new(:filename => "lanudo.jpg", :type => "image/jpg", :tempfile => file) 
  end
end