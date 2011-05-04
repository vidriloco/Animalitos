# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')
include Warden::Test::Helpers  

feature "Pagina Principal" do
  background do
    visit '/'
    @usuario = Factory.build(:usuario)
    @usuario.confirm!
  end

  describe "Encontré a una mascota", :js => true do
   
    scenario "me manda a iniciar sesión si no estoy logeado antes de poder registrarla" do
      click_on('Reporta')
      current_path.should == new_usuario_session_path
    end
        
    scenario "puedo registrarla desde la página principal si estoy logeado" do
      Factory(:beagle)
      login_as @usuario
      
      click_on('Reporta')
      
      current_path.should == new_animal_path
      
      page.should have_content('Registro de amigo en apuros')
      
      select('Encontré a un animalito en la calle', :from => 'animal_situacion')
      
      check('animal_tiene_placa')
      fill_in('Nombre', :with => 'Capitán')
      select('Beagle', :from => 'Raza')
      fill_in('Descripción', :with => 'Es un perro muy amable y dócil. Debe tener poco tiempo de haberse extraviado')
      select('Mí casa', :from => 'Estancia temporal')
      select('Macho', :from => 'Sexo')
      check('animal_cruza')
      click_on('Guardar')
      
      current_path.should == animal_path(Animal.first)
      page.should have_content('¡El animalito fue registrado correctamente!')
      
      page.should have_content('Capitán')
      page.should have_content('En casa temporal')
      page.should have_content('Perrito Beagle')
      page.should have_content('Cruza')
      page.should have_content('Encontrado')
      sleep 5
      page.should have_content('San Antonio 1725, Narvarte, Benito Juárez, Mexico City, Distrito Federal, Mexico')
    end
  
    scenario "habiéndola registrado previamente, puedo cerrar el caso y re-abrirlo también" do
      @animal=Factory(:animal, :raza => Factory(:beagle), :usuario => @usuario)
      login_as @usuario
      
      visit "/animales/#{@animal.id}"
      page.should have_content('Caso no resuelto aún')
      click_on('Cerrar caso')
      page.driver.browser.switch_to.alert.accept
      current_path.should == "/animales/#{@animal.id}"
      page.should_not have_xpath('//a', :text => "Modificar") 
      click_on('Re-abrir caso')
      page.driver.browser.switch_to.alert.accept
      current_path.should == "/animales/#{@animal.id}"
    end
    
    scenario "si tiene una PLACA con su NOMBRE debo poder ver una sugerencia de mascotas extravíadas ya registradas con ese nombre" 
  end

  describe "Mi mascota está extraviada" do
    
    scenario "si intento buscar sin dar un nombre de mascota y el tipo de mascota me dejará en la misma página principal" do
      click_on("Buscar")
      current_path.should == '/'
    end
    
    
    describe "Si alguien ya la registró como encontrada" do
      
      background do
        @perrito = Factory(:animal, :nombre => "capitán")
        @perrito_dos = Factory(:animal, :raza => @perrito.raza)
      end
      
      scenario "debo verla listada en los resultados de búsqueda al buscarla desde la página principal", :js => true do
        #PAGINACION A 1
        
        class Animal
          class << self
           cattr_writer :per_page
           @@per_page = 1
          end
        end
        
        fill_in("busqueda_nombre", :with => "Capitán")
        click_on("Buscar")
        
        current_path.should == '/busqueda'
        page.should have_content('Resultados de la búsqueda')
        find_link('capitán')
        page.should have_content('Siendo buscado')
        click_link('Siguiente')
        sleep 5
        click_link('Capitán')
        
        # Probar History. 
        # Guarda la lista de URLs visitadas previas, lo cuál es un error
        # Ocurre solamente en pruebas
        #current_path.should == "/animales/#{@perrito_dos.id}"
        #click_on('Atrás')
        #current_path.should == '/animales#page=2'
        #sleep 4
        #find_link('Capitán')
      end
    end
    
    describe "Si alguien no la ha registrado como encontrada" do
      scenario "puedo buscarla desde la página principal y posteriormente registrarla si estoy logeado" do
        login_as @usuario
                
        fill_in("busqueda_nombre", :with => "Capitán")
        
        click_on('Buscar')
        
        current_path.should == '/busqueda'
        
        page.should have_content('Resultados de la búsqueda')
        page.should have_content('Lo siento. No se encontraron animalitos con los datos proporcionados')
        page.should have_content('Te invitamos a registrar tú mascota como extraviada')
        
        click_on('Registrar')
        
        current_path.should == new_animal_path 
      end
      
      scenario "me manda a iniciar sesión si no estoy logeado antes de poder registrarla después de haberla buscado y no encontrado" do
        fill_in("busqueda_nombre", :with => "Capitán")
        
        click_on('Buscar')
        
        current_path.should == '/busqueda'
        page.should_not have_content('Nuevo Animal')
        click_on('Registrar')
        
        current_path.should == new_usuario_session_path
      end
    end
    
  end

  describe "habiendo algunas mascotas registradas", :js => true do
    
    background do
      ahora = Time.now
      Factory(:pastor_con_foto, :fecha => ahora.months_ago(1))
      Factory(:akita_con_foto, :fecha => ahora.months_ago(1))
      @dulcinea=Factory(:cooker_con_foto, :fecha => ahora)
    end
   
    scenario "debo ver en ella diversos contenidos" do
      visit '/'
      find_link('Registro')
      find_link('Iniciar Sesión')
      find_link('Acerca de')
    
      page.should have_content('¿Tú mascota se extravió?')
      page.should have_content('¿Buscas una mascota?')
      page.should have_content('¿Encontraste un animalito en la calle?')
      find_field('busqueda_nombre')
      find_field('busqueda_raza')
      find_button('Buscar')
      
      find_link('Encuentra')
      page.should have_content('1 en adopción o encontrada')
      
      find_link('Reporta')      
      page.should have_content('2 reportadas como extraviadas')
      
      page.should have_content('Dulcinea')
      page.should have_content('Extraviado hace menos de 1 minuto')
      sleep 15
      page.should have_content('Mokita')
      page.should have_content('Extraviado hace 30 días')
      sleep 15
      page.should have_content('Laika')
      page.should have_content('Encontrado hace 30 días')
      
    end  
 

    scenario "al dar click en registro debe mandarme a la pagina de registro" do
      visit '/'
      click_link('Registro')
      current_path.should == new_usuario_registration_path
    end
    
    scenario "al dar click en login debe mandarme a la pagina de inicio de sesión" do
      visit '/'
      click_link('Iniciar Sesión')
      current_path.should == new_usuario_session_path
    end
    
    scenario "al dar click en acerca de debe mandarme a la pagina de detalles del sitio" do
      visit '/'
      click_link('Acerca de')
      current_path.should == acerca_de_path
    end
  end

  describe "Quiero una mascota" do

    scenario "al dar click en el botón para encontrar mascotas puedo seleccionar una mascota de acuerdo a diferentes parámetros" do
      click_on('Encuentra')
      
      current_path.should == '/animales'
    end
    
    scenario "debo ver un conjuto de campos para poder realizar una busqueda avanzada", :js => true do
      click_on('Encuentra')
      
      click_on('Búsqueda')
      page.should have_content('Buscar amigos en apuros que tengan:')
      page.should have_field('busqueda_nombre')
      page.should have_field('busqueda_raza')
      page.should have_field('busqueda_cruza')
      page.should have_field('busqueda_sexo')
      page.should have_field('busqueda_extraviado')
      page.should have_field('busqueda_adopcion')
      
      find_button('Buscar')
    end   
    
    scenario "al hacer una busqueda puede ser que no es encuentren resultados", :js => true do
      click_on('Encuentra')
      
      click_on('Búsqueda')
      
      fill_in('busqueda_nombre', :with => 'Gregorio')
      
      click_on('Buscar')
      
      page.should have_content('Lo siento. No se encontraron animalitos con los datos proporcionados')
    end
    
    scenario "al hacer una busqueda puede ser también que se encuentren resultados", :js => true do
      Factory(:pastor_con_foto)
      visit('/animales')
      
      click_on('Búsqueda')
      fill_in('busqueda_nombre', :with => 'Laika')
      check('busqueda_adopcion')
      select('Pastor Alemán', :from => 'busqueda_raza')
      
      click_on('Buscar')
      
      page.should have_content('Laika')
    end
  
    scenario "en la busqueda puedo excluir a los resultados que son casos cerrados", :js => true do
      Factory(:pastor_con_foto, :caso_cerrado => true)
      visit('/animales')
      
      click_on('Búsqueda')
      check('busqueda_caso_cerrado')
      
      click_on('Buscar')
      page.should have_content('Lo siento. No se encontraron animalitos con los datos proporcionados')
    end
  end
 
end
