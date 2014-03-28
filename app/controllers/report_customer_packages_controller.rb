class ReportCustomerPackagesController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
  end

  def show
    @customer = Customer.find_by(identity: params[:customer_id])
    
    #si el id no es valido, volvemos a cargar la pagina
    if @customer.blank?
      redirect_to action: "index"
      return
    else
      @customerPackages = Package.where(customer: @customer)
    end
  end
end
