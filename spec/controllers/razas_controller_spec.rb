require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe RazasController do

  def mock_raza(stubs={})
    @mock_raza ||= mock_model(Raza, stubs).as_null_object
  end
  
  before(:each) do
    usuario = Factory(:usuario)
    #usuario.confirm! 
    sign_in(usuario)
  end

  describe "GET index" do
    it "assigns all razas as @razas" do
      Raza.stub(:all) { [mock_raza] }
      get :index
      assigns(:razas).should eq([mock_raza])
    end
  end

  describe "GET new" do
    it "assigns a new raza as @raza" do
      Raza.stub(:new) { mock_raza }
      get :new
      assigns(:raza).should be(mock_raza)
    end
  end

  describe "GET edit" do
    it "assigns the requested raza as @raza" do
      Raza.stub(:find).with("37") { mock_raza }
      get :edit, :id => "37"
      assigns(:raza).should be(mock_raza)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created raza as @raza" do
        Raza.stub(:new).with({'these' => 'params'}) { mock_raza(:save => true) }
        post :create, :raza => {'these' => 'params'}
        assigns(:raza).should be(mock_raza)
      end

      it "redirects to the list of razas" do
        Raza.stub(:new) { mock_raza(:save => true) }
        post :create, :raza => {}
        response.should redirect_to(razas_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved raza as @raza" do
        Raza.stub(:new).with({'these' => 'params'}) { mock_raza(:save => false) }
        post :create, :raza => {'these' => 'params'}
        assigns(:raza).should be(mock_raza)
      end

      it "re-renders the 'new' template" do
        Raza.stub(:new) { mock_raza(:save => false) }
        post :create, :raza => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested raza" do
        Raza.stub(:find).with("37") { mock_raza }
        mock_raza.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :raza => {'these' => 'params'}
      end

      it "assigns the requested raza as @raza" do
        Raza.stub(:find) { mock_raza(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:raza).should be(mock_raza)
      end

      it "redirects to the raza" do
        Raza.stub(:find) { mock_raza(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(raza_url(mock_raza))
      end
    end

    describe "with invalid params" do
      it "assigns the raza as @raza" do
        Raza.stub(:find) { mock_raza(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:raza).should be(mock_raza)
      end

      it "re-renders the 'edit' template" do
        Raza.stub(:find) { mock_raza(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested raza" do
      Raza.stub(:find).with("37") { mock_raza }
      mock_raza.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the razas list" do
      Raza.stub(:find) { mock_raza }
      delete :destroy, :id => "1"
      response.should redirect_to(razas_url)
    end
  end

end
