class ReportTicketsDayController < ApplicationController
  def index
    #Verificamos si algun cliente ha iniciado sesion
    if !user_signed_in?
      flash[:notice] = "Please login first"
      redirect_to url_for(:controller => :main, :action => :index)
      return
    end
  end

  def show
    day = params[:day]
    month = params[:month]
    year = params[:year]
    
    #Validamos si NO es integer
    if day.to_i.to_s != day
      redirect_to action: "index"
      return
    end
    
    #Validamos si el dia es invalido
    if day.to_i < 1 || day.to_i > 31
      redirect_to action: "index"
      return
    end
    
    #Validamos si NO es integer
    if month.to_i.to_s != month
      redirect_to action: "index"
      return
    end
    
    #Validamos si el mes es invalido
    if month.to_i < 1 || month.to_i > 12
      redirect_to action: "index"
      return
    end
    
    #Validamos si NO es integer
    if year.to_i.to_s != year
      redirect_to action: "index"
      return
    end
    
    #Validamos si el año es invalido
    if year.to_i < 2014
      redirect_to action: "index"
      return
    end
    
    @tickets = Ticket.find_by_sql('select * from tickets t join hours h on t.hour_id = h.id
                                   where DAY(h.hour) = ' + day + ' and MONTH(h.hour) = ' + month + ' and YEAR(h.hour) = ' + year)
  end
end
