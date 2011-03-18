class FrenteController < ApplicationController
  
  before_filter :admin_contenidos
  
  def index
    @desplegando_frente = true
  end
  
  def admin_contenidos
    if usuario_signed_in?
      @usuarios = Usuario.all
    end
  end
end
