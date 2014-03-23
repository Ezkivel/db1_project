class TicketsController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
    
    @customerModel = Customer.new
  end
  
  def create
    #id de la estacion seleccionada
    stationId = params[:ticket][:station]
    
    #------------------------------informacion necesaria para la tabla hora------------------------------------
    
    # ¨x¨cantidad de dias apartir de hoy
    days = params[:ticket][:days]
    
    hour = params[:ticket][:hour]
    h = hour.split(':')[0].strip
    min = hour.split(':')[1].strip
    
    #fecha de salida para el boleto
    checkOutTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, h.to_i, min.to_i, 0).in_time_zone + days.to_i.days
    
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
    
    selectedHourModel = Hour.where(hour: checkOutTime, destination: destination, bus_id: busId).take    
    #Verificamos si existe una hora(fecha) con el bus correspondiente
    if !selectedHourModel.blank?
      #Verificamos si a esa hora|bus no hay asientos disponibles
      if Hour.where(hour: checkOutTime, destination: destination, bus_id: busId).count >= 40
        flash[:notice] = "No seats availables."
        redirect_to action: 'index'
        return
      end
      
      seatTemp = params[:ticket][:seat]      
      #Verificamos si existe un boleto con el mismo asiento para la misma fecha(hora)
      if Ticket.exists?(seat: seatTemp, hour: selectedHourModel)
        flash[:notice] = "The seat is not available."
        redirect_to action: 'index'
        return
      end
    end
            
    hourModel = Hour.new(hour: checkOutTime, destination: destination, bus_id: busId)
    
    #---------------------------------------Cliente y Empleado------------------------------------------
        
    #Instanciamos un nuevo cliente
    @customerModel = Customer.new(params[:ticket].permit(:identity, :name, :surname, :gender))
    
    #si el cliente no existe, se crea
    if !Customer.exists?(identity: @customerModel.identity)
      #Verificamos si hay algun problema antes de guardar el cliente
      if !@customerModel.save
        render 'index' #actualizamos la pagina y mostramos el problema
        return
      end
    else #de lo contrario, obtemos el cliente
      @customerModel = Customer.find_by(identity: @customerModel.identity)
      
      #Verificamos si el cliente ya habia comprado un boleto para esa fecha(hora)
      if !Ticket.exists?(customer: @customerModel, hour: selectedHourModel)
        hourModel.save #Guardamos la hora
      else
        flash[:notice] = "You already reserved a ticket."
        redirect_to action: 'index'
        return
      end
    end
    
    #Obtenemos el empleado
    employeeModel = Employee.where(email: current_user.email).take
    
    #----------------------------------------------------Boleto----------------------------------------------------
    
    reservationDate = DateTime.now.in_time_zone
    seat = params[:ticket][:seat]
    ticketType = params[:ticket][:ticket_type]
    
    discount = 0;
    
    if ticketType == 'Senior'
      discount = 50
    elsif ticketType == 'Student'
      discount = 30
    end
    
    total = 150 - discount
    
    ticketModel = Ticket.new(reservation_date: reservationDate, seat: seat, ticket_type: ticketType, discount: discount, total: total, customer: @customerModel, employee: employeeModel, hour: hourModel)
    
    if ticketModel.save
      sql = "insert into hours_stations(hour_id, station_id) values(" + hourModel.id.to_s + ", " + stationId.to_s + ")"
      ActiveRecord::Base.connection.execute(sql)
    end
    
    flash[:notice] = "Ticket reserved!"
    
    redirect_to action: "show"
  end
  
  def show
    @ticketModel = Ticket.last
  end
end
