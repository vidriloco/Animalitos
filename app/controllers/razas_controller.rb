class RazasController < ApplicationController
  before_filter :authenticate_usuario!
  
  # GET /razas
  # GET /razas.xml
  def index
    @razas = Raza.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @razas }
    end
  end

  # GET /razas/new
  # GET /razas/new.xml
  def new
    @raza = Raza.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @raza }
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
        format.xml  { render :xml => @raza, :status => :created, :location => @raza }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @raza.errors, :status => :unprocessable_entity }
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
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @raza.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end
end
