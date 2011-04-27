# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')
include Warden::Test::Helpers  

feature "Pagina Principal" do
  background do
    visit '/'
    @usuario = Factory.build(:usuario)
    @usuario.confirm!
    Factory(:beagle)
  end

  describe "Encontré a una mascota", :js => true do
    
    scenario "me manda a iniciar sesión si no estoy logeado antes de poder registrarla" do
      click_on('Reporta')
      current_path.should == new_usuario_session_path
    end
        
    scenario "puedo registrarla desde la página principal si estoy logeado" do
      login_as @usuario
      
      click_on('Reporta')
      
      current_path.should == new_animal_path
      
      page.should have_content('Registro de amigo en apuros')
      
      select('Encontré a un animalito en la calle', :from => 'animal_situacion')
      
      check('Tiene placa')
      fill_in('Nombre', :with => 'Capitán')
      select('Beagle', :from => 'Raza')
      fill_in('Descripción', :with => 'Es un perro muy amable y dócil. Debe tener poco tiempo de haberse extraviado')
      select('Mí casa', :from => 'Estancia temporal')
      click_on('Guardar')
      
      current_path.should == animal_path(Animal.first)
      page.should have_content('¡El animalito fue registrado correctamente!')
      
      page.should have_content('Capitán')
      page.should have_content('En casa temporal')
      page.should have_content('Beagle')
      page.should have_content('Encontrado')
      sleep 5
      page.should have_content('San Antonio 1725, Narvarte, Benito Juárez, Mexico City, Distrito Federal, Mexico')
    end
    
    scenario "si tiene una PLACA con su NOMBRE debo poder ver una sugerencia de mascotas extravíadas ya registradas con ese nombre" 
  end

  describe "Mi mascota está extraviada" do
    
    describe "Si alguien ya la registró como encontrada" do
      
      background do
        @perrito = Factory(:animal)
      end
      
      scenario "debo verla listada en los resultados de búsqueda al buscarla desde la página principal" do
        fill_in("busqueda", :with => "Capitán")
        check("Perro")
        
        click_on("Buscar")
        
        current_path.should == animales_url 
        page.should have_content('Resultados de perritos con nombre: Capitán')
        page.should have_content('Capitán')
      end
    end
    
    describe "Si alguien no la ha registrado como encontrada" do
      scenario "puedo buscarla desde la página principal y posteriormente registrarla si estoy logeado" do
        login_as @usuario
                
        fill_in("busqueda", :with => "Capitán")
        check("Perro")
        
        click_on('Buscar')
        
        current_path.should == animales_url
        
        page.should have_content('Resultados de perritos con nombre: Capitán')
        page.should have_content('Por ahora no existe ningún registro de algún perrito con ese nombre')
        page.should have_content('Te invitamos a registrar tú mascota como extraviada')
        
        click_on('Registrar')
        
        current_path.should == new_animal_path 
      end
      
      scenario "me manda a iniciar sesión si no estoy logeado antes de poder registrarla después de haberla buscado y no encontrado" do
        fill_in("busqueda", :with => "Capitán")
        check("Perro")
        
        click_on('Buscar')
        
        current_path.should == animales_url
        click_on('Registrar')
        
        current_path.should == new_usuario_session_path
      end
    end
    
  end
  
  describe "habiendo algunas mascotas registradas" do
    
    background do
      @escogido=Factory(:animal, :nombre => "Lanudo", :situacion => 1, :fecha => Time.now.months_ago(1))
      Factory(:animal, :nombre => "Froyo", :situacion => 2, :fecha => Time.now.months_ago(2))
      Factory(:animal, :nombre => "Blacky", :situacion => 2)
    end
    
    scenario "debo ver en ella diversos contenidos" do
      page.should have_content('Registrarse')
      page.should have_content('Login')
      page.should have_content('Ayuda')
    
      page.should have_content('¿Tú mascota se extravió?')
      page.should have_content('¿Quieres adoptar una mascota?')
      page.should have_content('¿Encontraste un animalito en la calle?')
    
      page.should have_content('Busca')
      page.should have_content('Encuentra')
      page.should have_content('Reporta')
      
      page.should have content('Lanudo')
      page.should have content('Extraviado hace cerca de 1 mes')
      sleep 10
      page.should have content('Froyo')
      page.should have content('Encontrado hace cerca de 2 meses')
      sleep 10
      page.should have content('Blacky')
      page.should have content('Encontrado hace cerca de ')
    end  
    
    scenario "al dar click en alguna de las mascotas que van cambiando puedo ver su perfil" do
      click_on('Lanudo')
      
      current_path.should ==  animal_url(@escogido)
    end
  end
  
  describe "Quiero una mascota" do
    scenario "al dar click en el botón para encontrar mascotas puedo seleccionar una mascota de acuerdo a diferentes parámetros" do
      click_on('Encuentra')
      
      current_path.should == animales_url
    end
  end
  
end
