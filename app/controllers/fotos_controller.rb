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
    @foto = Foto.new(params[:foto].merge(:animal_id => params[:animal_id]))
    
    if @foto.asocia_carrierwave(params[:archivo])
      @animal = Animal.find(params[:animal_id])
      @animal.update_attribute(:foto_id, @foto.id) if params[:principal] == "true"
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
    @foto = Foto.first(:conditions => {:id => params[:id]})
    
    @foto.remove_carrierwave!
    @foto.destroy
    
    respond_to do |format|
      format.js # destroy.js.erb
    end
  end
end