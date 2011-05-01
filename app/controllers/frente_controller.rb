class FrenteController < ApplicationController
  
  before_filter :admin_contenidos
  
  def index
    redirect_to(animales_path) if usuario_signed_in?
    
    @mascotas = Animal.all(:order => "animales.id DESC", :conditions => "foto_id IS NOT NULL", :include => :fotos, :limit => 5)
    @extraviados = Animal.count(:conditions => {:situacion => Animal.extraviado})
    @encontrados = Animal.count(:conditions => {:situacion => Animal.encontrado})
  end
  
  def admin_contenidos
    if usuario_signed_in?
      @usuarios = Usuario.all
    end
  end
  
  def acerca_de
    
  end
end
