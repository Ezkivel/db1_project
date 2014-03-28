class PackagesController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
    
    @customerModel = Customer.new
    @packageModel = Package.new
  end

  def create
    #Obtenemos el empleado
    employeeModel = Employee.where(email: current_user.email).take
    
    stationId = employeeModel.station_id
    
    #------------------------------informacion necesaria para la tabla hora------------------------------------
    
    hour = params[:package][:hour]
    h = hour.split(':')[0].strip
    min = hour.split(':')[1].strip
    
    #fecha de salida para el boleto
    checkOutTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, h.to_i, min.to_i, 0).in_time_zone
    
    destination = 'Choluteca'

    if stationId == '2'
      destination = 'Tegucigalpa'
    end
    
    busId = 1
    
    if stationId == '1' && hour == '04:00'
      busId = 1
      
    elsif stationId == '1' && hour == '06:00'
      busId = 3
      
    elsif stationId == '1' && hour == '08:00'
      busId = 1
      
    elsif stationId == '1' && hour == '10:00'
      busId = 3
     
    elsif stationId == '1' && hour == '12:00'
      busId = 2
      
    elsif stationId== '1' && hour == '14:00'
      busId = 4
      
    elsif stationId == '1' && hour == '16:00'
      busId = 2
      
    elsif stationId == '1' && hour == '18:00'
      busId = 4
      
    elsif stationId == '2' && hour == '04:00'
      busId = 3
      
    elsif stationId == '2' && hour == '06:00'
      busId = 1
      
    elsif stationId == '2' && hour == '08:00'
      busId = 3
      
    elsif stationId == '2' && hour == '10:00'
      busId = 1
     
    elsif stationId == '2' && hour == '12:00'
      busId = 4
      
    elsif stationId == '2' && hour == '14:00'
      busId = 2
      
    elsif stationId == '2' && hour == '16:00'
      busId = 4
      
    elsif stationId == '2' && hour == '18:00'
      busId = 2
    end
    
    hourModel = Hour.new(hour: checkOutTime, destination: destination, bus_id: busId)
    
    #---------------------------------------Cliente------------------------------------------
        
    #Instanciamos un nuevo cliente
    @customerModel = Customer.new(params[:package].permit(:identity, :name, :surname, :gender))
    
    #si el cliente no existe, se crea
    if !Customer.exists?(identity: @customerModel.identity)
      #Verificamos si hay algun problema antes de guardar el cliente
      if !@customerModel.save
        render 'index' #actualizamos la pagina y mostramos el problema
        return
      end
    else #de lo contrario, obtemos el cliente
      @customerModel = Customer.find_by(identity: @customerModel.identity)
    end
    
    
    #--------------------------------------Paquete----------------------------------------------
    packageType = params[:package][:package_type]
    addressee = params[:package][:addressee]
    
    if addressee.blank?
      render 'index' #actualizamos la pagina y mostramos el problema
      return
    end
    
    total = 40 #valor del sobre
    
    if packageType == "Caja pequeña"
      total = 50
    elsif packageType == "Caja mediana"
      total = 75
    elsif packageType == "Caja grande"
      total = 90
    end
    
    @packageModel = Package.new(package_type: packageType, addressee: addressee, total: total, customer: @customerModel, employee: employeeModel, hour: hourModel)
    
    if !@packageModel.save
      render 'index' #actualizamos la pagina y mostramos el problema
      return
    else
      redirect_to action: "show"
      return
    end
  end

  def show
    @packageModel = Package.last
  end
end
