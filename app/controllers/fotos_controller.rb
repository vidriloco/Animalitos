class FotosController < ApplicationController
  
  def index
    if params[:animal_id]
      @animal = Animal.first(:conditions => {:id => params[:animal_id]}, :include => :fotos)
      
      respond_to do |format|
        format.js # render index.js.erb
      end
    else
      
    end
  end
  
  def create
    archivo = params[:foto][:archivo]
    params[:foto].delete(:archivo)
    
    @foto = Foto.new(params[:foto].merge(:animal_id => params[:animal_id]))
    
    unless archivo.nil?
      @foto.mime_type = archivo.content_type
      @foto.carrierwave = archivo
    end
    
    if @foto.save    
      if params[:principal] == "true"
        @animal = Animal.find(params[:animal_id])
        @animal.update_attribute(:foto_id, @foto.id)
      end
    end
  end
  
  def update
    @foto = Foto.find(params[:id], :joins => :animal, :include => :animal)
    @animal = @foto.animal
    @foto_id_previa = @animal.foto_id
    @actualizado = @foto.animal.update_attribute(:foto_id, params[:id])
    
    respond_to do |format|
      format.js # update.js.erb
    end
  end
  
  
  def destroy
    @foto_id = params[:id]
    @foto = Foto.first(:conditions => {:id => @foto_id})
    
    @foto.remove_carrierwave!
    @foto.destroy
    
    respond_to do |format|
      format.js # destroy.js.erb
    end
  end
end