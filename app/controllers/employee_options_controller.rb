class EmployeeOptionsController < ApplicationController
  def index
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
    
    #Obtenemos el empleado
    @employeeModel = Employee.where(email: current_user.email).take
  end
end
