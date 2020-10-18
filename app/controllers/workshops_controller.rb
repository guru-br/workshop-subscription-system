class WorkshopsController < ApplicationController
  before_action :authenticate_user!, except: :show
  # GET
  def new
  end

  # POST
  def create
    workshop = Workshop.new(workshop_params)
    workshop.save
    redirect_to workshop, notice: 'Workshop registrado com sucesso' # direciona pro show 
  end

  # GET /workshops/:id
  def show
    @workshop = Workshop.find(params[:id])
		if !user_signed_in? && @workshop.draft?
			redirect_to root_path, notice: 'Este workshop está indisponível'
		end
  end

  # PATCH /workshops/:id/activate
  def activate
    workshop = Workshop.find(params[:id])
    workshop.active!
    redirect_to workshop, notice: 'Workshop atualizado com sucesso'
  end

  private

  def workshop_params
    #Strong Parameters
    params.require(:workshop).permit(:name, :short_description,
                                     :full_description, :duration,
                                     :attendees, :workshop_date,
                                     :start_time)
  end
end
