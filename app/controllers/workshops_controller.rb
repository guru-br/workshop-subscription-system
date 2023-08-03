# frozen_string_literal: true

class WorkshopsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # INDEX
  def index
    @workshops = Workshop.future
  end

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
    @enrollment = Enrollment.find_by(attendee: current_attendee, workshop: @workshop)

    return if can_view_workshop?(@workshop.draft?)

    redirect_to root_path, notice: I18n.t('workshops.notices.show.draft')
  end

  def edit
    @workshop = Workshop.find(params[:id])
  end

  def update
    workshop = Workshop.find(params[:id])
    workshop.update!(workshop_params)
    redirect_to edit_workshop_path(workshop),
                notice: I18n.t('workshops.notices.edit.success',
                               name: workshop.name)
  end

  private

  def workshop_params
    # Strong Parameters
    params.require(:workshop).permit(:name, :short_description,
                                     :full_description, :duration,
                                     :attendees, :workshop_date,
                                     :start_time, :status)
  end

  def can_view_workshop?(draft_workshop)
    return true if user_signed_in?

    attendee_signed_in? && !draft_workshop ? true : false
  end
end
