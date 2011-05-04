class UsuariosController < ApplicationController
  before_filter :comun, :except => [:perfil, :admin_contenidos]
  before_filter :admin_contenidos, :only => [:perfil, :activar, :desactivar]
  
  def comun
    @usuario = Usuario.find(params[:id])
  end
  
  # DELETE /razas/1
  # DELETE /razas/1.xml
  def destroy
    @usuario_id = @usuario.id
    @usuario.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def activar
    @usuario.confirm!
    #Notificador.activacion(@usuario).deliver
    
    respond_to do |format|
      format.js { render 'controles_admin' }
    end
  end
  
  def desactivar
    @usuario.unconfirm!
    #Notificador.desactivacion(@usuario).deliver    
    
    respond_to do |format|
      format.js { render 'controles_admin' }
    end
  end
  
  def perfil
    @usuario = current_usuario
    @animales = @usuario.animales
    render :layout => 'perfil'
  end
  
  def admin_contenidos
    if usuario_signed_in?
      @usuarios = Usuario.all
    else
      authenticate_usuario!
    end
  end
end
