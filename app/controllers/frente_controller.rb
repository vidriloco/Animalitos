class FrenteController < ApplicationController
  
  before_filter :admin_contenidos
  
  def index
    redirect_to(animales_path) if usuario_signed_in?
    @desplegando_frente = true
  end
  
  def admin_contenidos
    if usuario_signed_in?
      @usuarios = Usuario.all
    end
  end
end
