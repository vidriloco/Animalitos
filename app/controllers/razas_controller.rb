class RazasController < ApplicationController
  before_filter :authenticate_usuario!
  
  # GET /razas
  # GET /razas.xml
  def index
    @razas = Raza.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /razas/new
  # GET /razas/new.xml
  def new
    @raza = Raza.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /razas/1/edit
  def edit
    @raza = Raza.find(params[:id])
  end

  # POST /razas
  # POST /razas.xml
  def create
    @raza = Raza.new(params[:raza])

    respond_to do |format|
      if @raza.save
        format.html { redirect_to(@raza, :notice => 'Raza was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /razas/1
  # PUT /razas/1.xml
  def update
    @raza = Raza.find(params[:id])

    respond_to do |format|
      if @raza.update_attributes(params[:raza])
        format.html { redirect_to(@raza, :notice => 'Raza was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /razas/1
  # DELETE /razas/1.xml
  def destroy
    @raza = Raza.find(params[:id])
    @raza.destroy

    respond_to do |format|
      format.html { redirect_to(razas_url) }
    end
  end
end
