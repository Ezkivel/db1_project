class ReportEmployeesController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
    
    @employees = Employee.all
  end
end
