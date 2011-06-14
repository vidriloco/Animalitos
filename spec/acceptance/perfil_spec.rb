# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')
include Warden::Test::Helpers  

feature "Perfil" do
  background do
    @usuario = Factory(:usuario)
    login_as @usuario
  end
  
  describe "No habiendo animalitos registrados" do
    scenario "dado que estoy logeado puedo ver mí perfil" do
      visit "/perfil"
      
      page.should have_content('Mis animalitos')
      
      page.should have_content('No tienes animales registrados por el momento')
      find_link('Registrar nuevo')
    end
  end
  
  
  describe "Habiendo algunos animalitos registrados" do
    
    before(:each) do
      @animal = Factory(:akita_con_foto, :usuario => @usuario, :caso_cerrado => true, :fecha => Time.now)
      Factory(:pastor_con_foto, :usuario => @usuario, :caso_cerrado => false)
      
    end
    
    scenario "yendo a la página del animalito, si estoy logueado y yo lo registré" do
      visit "/animales/#{@animal.id}"
      
      page.should have_content('Datos de usuario contacto')
      page.should have_content(@usuario.nombre)
      click_on('Actualizar mis datos')
      current_path.should == "/perfil"
    end
    
    scenario "dado que estoy logeado puedo ver mí perfil y en el los animalitos registrados" do
      visit "/perfil"
      
      page.should have_content('Mis animalitos')
      
      page.should have_content('Mokita')
      page.should have_content('Caso cerrado')
      
      page.should have_content('Laika')
      page.should have_content('Caso no resuelto aún')
      
      click_on('Ver')
      current_path.should == "/animales/#{@animal.id}"
    end
    
    scenario "dado que estoy logeado puedo cambiar datos de mi perfil" do
      visit '/perfil'
      
      click_on('Ir')
      current_path.should == '/usuarios/edit'
      
      click_on('Actualizar')
      current_path.should == "/usuarios"
      page.should have_content('Current password no puede estar en blanco')
      
      
      fill_in('usuario_current_password', :with => @usuario.password)
      fill_in('Cuenta en Twitter', :with => "vidriloco")
      
      click_on('Actualizar')
      current_path.should == "/usuarios"
      page.should have_content('Cuenta en twitter es inválido')
      
      fill_in('Cuenta en Twitter', :with => "@vidriloco")
      click_on('Actualizar')
      current_path.should == "/usuarios"
      page.should have_content('Current password no puede estar en blanco')
      
      fill_in('Cuenta en Twitter', :with => "@vidriloco")
      fill_in('usuario_current_password', :with => @usuario.password)
      
      click_on('Actualizar')
      current_path.should == "/perfil"
    end
    
  end
  
end