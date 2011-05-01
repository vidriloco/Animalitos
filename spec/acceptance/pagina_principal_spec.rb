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
    
    scenario "si tiene una PLACA con su NOMBRE debo poder ver una sugerencia de mascotas extravíadas ya registradas con ese nombre" 
  end

  describe "Mi mascota está extraviada" do
    
    scenario "si intento buscar sin dar un nombre de mascota y el tipo de mascota me dejará en la misma página principal" do
      click_on("Buscar")
      current_path.should == '/'
    end
    
    
    describe "Si alguien ya la registró como encontrada" do
      
      background do
        @perrito = Factory(:animal)
        @perrito_dos = Factory(:animal, :raza_id => @perrito.raza.id)
      end
      
      scenario "debo verla listada en los resultados de búsqueda al buscarla desde la página principal" do
        #PAGINACION A 1
        
        class Animal
          class << self
           cattr_writer :per_page
           @@per_page = 1
          end
        end
        
        fill_in("busqueda_nombre", :with => "Capitán")
        check("busqueda_perro")
        
        click_on("Buscar")
        
        current_path.should == '/busqueda'
        page.should have_content('Resultados de perritos extraviados con nombre Capitán')
        page.should have_content('Capitán')
        page.should have_content('Siendo buscado')
        click_link('Siguiente')
        page.should have_content('Capitán')
      end
    end
    
    describe "Si alguien no la ha registrado como encontrada" do
      scenario "puedo buscarla desde la página principal y posteriormente registrarla si estoy logeado" do
        login_as @usuario
                
        fill_in("busqueda_nombre", :with => "Capitán")
        check("busqueda_perro")
        
        click_on('Buscar')
        
        current_path.should == '/busqueda'
        
        page.should have_content('Resultados de perritos extraviados con nombre Capitán')
        page.should have_content('Por ahora no hay registrado ningún perrito con ese nombre')
        page.should have_content('Te invitamos a registrar tú mascota como extraviada')
        
        click_on('Registrar')
        
        current_path.should == new_animal_path 
      end
      
      scenario "me manda a iniciar sesión si no estoy logeado antes de poder registrarla después de haberla buscado y no encontrado" do
        fill_in("busqueda_nombre", :with => "Capitán")
        check("busqueda_perro")
        
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
      find_field('busqueda_perro')
      find_field('busqueda_gato')
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
  end
  
end
