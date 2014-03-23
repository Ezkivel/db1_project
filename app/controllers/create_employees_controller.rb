class CreateEmployeesController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
    
    @newEmployeeModel = Employee.new
    
    #Obtenemos el empleado
    @currentEmployeeModel = Employee.where(email: current_user.email).take
  end

  def create
    #Creamos el un usuario
    user = User.new(params[:new_employee].permit(:email, :password))
    #Verificamos si no se dejo la contraseña en blanco
    if user.password.blank?
      flash[:notice] = "Specified a password"
      redirect_to action: "index"
      return
    end
    
    @newEmployeeModel = Employee.new(params[:new_employee].permit(:identity, :name, :surname, :age, :gender, :employee_type, :email, :station_id))
    
    #Verificamos si el cliente no existe en la bd para salvarlo
    if !Employee.exists?(identity: @newEmployeeModel.identity)
      #Verificamos si hay algun error al intentar guardar el empleado
      if !@newEmployeeModel.save
        render "index"
        return      
      else
        user.save      
        redirect_to action: "show"
        return
      end
    else
      flash[:notice] = "The employee already exists"
      redirect_to action: "index"
      return
    end
    
  end

  def show
    @createdEmployeeModel = Employee.last
  end
end
