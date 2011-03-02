#encoding: utf-8

class Notificador < ActionMailer::Base
  default :from => "clusterciudadano@gmail.com"

  def desactivacion(usuario)
    notificacion_comun(usuario, 'Tú cuenta en animalitos ha sido desactivada. :(')
  end
  
  def activacion(usuario)
    notificacion_comun(usuario, 'Tú cuenta en animalitos ha sido activada! :)')
  end
  
  def reset_password_instruccions(usuario)
    notificacion_comun(usuario, 'Instrucciones para restaurar tú contraseña')
  end
  
  def notificacion_comun(usuario, msj)
    mail(:to => usuario.email,
         :subject => msj)
    end
  end
end
