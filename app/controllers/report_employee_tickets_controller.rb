class ReportEmployeeTicketsController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
  end

  def show
    @employee = Employee.find_by(identity: params[:employee_id])
    
    #si el id no es valido, volvemos a cargar la pagina
    if @employee.blank?
      redirect_to action: "index"
      return
    else
      @employeeTickets = Ticket.where(employee: @employee)
    end
  end
end
