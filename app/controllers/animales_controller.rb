class AnimalesController < ApplicationController
  
  before_filter :authenticate_usuario!, :except => [:index, :show]
  # GET /animales
  # GET /animales.xml
  def index
    @animales = Animal.pagina_y_encuentra(params)
    
    respond_to do |format|
      format.html # index.html.erb
      
      format.js # index.js.erb   
    end
  end

  # GET /animales/1
  # GET /animales/1.xml
  def show
    @animal = Animal.find(params[:id], :include => :fotos)

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /animales/new
  # GET /animales/new.xml
  def new
    @animal = Animal.new
    @razas = Raza.all
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /animales/1/edit
  def edit
    @razas = Raza.all
    @animal = Animal.find(params[:id])
  end

  # POST /animales
  # POST /animales.xml
  def create
    @animal = Animal.new(params[:animal])
    @animal.geografia = Geografia.build_from(params["geografia"])

    respond_to do |format|
      if @animal.save
        format.html { redirect_to(@animal, :notice => 'Animalito registrado exitosamente') }
        format.xml  { render :xml => @animal, :status => :created, :location => @animal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animales/1
  # PUT /animales/1.xml
  def update
    @animal = Animal.find(params[:id])
    @animal.geografia.update_from(params["geografia"])

    respond_to do |format|
      if @animal.update_attributes(params[:animal])
        format.html { redirect_to(@animal, :notice => 'Datos del animalito actualizados exitosamente') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /animales/1
  # DELETE /animales/1.xml
  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    respond_to do |format|
      format.html { redirect_to(animales_url) }
    end
  end
  
end
