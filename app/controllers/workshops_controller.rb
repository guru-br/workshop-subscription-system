# frozen_string_literal: true

class WorkshopsController < ApplicationController
  before_action :authenticate_user!
  # GET
  def new; end

  # POST
  def create
    workshop = Workshop.new(workshop_params)
    workshop.save

    # direciona para o show
    redirect_to workshop, notice: 'Workshop registrado com sucesso'
  end

  # GET /workshops/:id
  def show
    @workshop = Workshop.find(params[:id])
  end

  private

  def workshop_params
    # Strong Parameters
    params.require(:workshop).permit(:name, :short_description,
                                     :full_description, :duration,
                                     :attendees, :workshop_date,
                                     :start_time)
  end
end
