class EmergenciesController < ApplicationController
  before_action :set_emergency, only: [:show, :update]

  def create
    emergency = Emergency.new(emergency_create_params)

    if emergency.save
      Domain::Dispatch::Dispatcher.dispatch(emergency)

      render json: emergency, status: :created
    else
      render_unprocessable_entity(message: emergency.errors)
    end
  end

  def index
    emergencies = Emergency.includes(:responders).all
    full_responses = Domain::Reports::FullResponseReport.calculate

    render json: emergencies, status: :ok, meta: full_responses, meta_key: 'full_responses'
  end

  def show
    render json: @emergency, status: :ok
  end

  def update
    if @emergency.update(emergency_update_params)
      Domain::Dispatch::Dispatcher.resolve(@emergency, emergency_update_params[:resolved_at])

      render json: @emergency, status: :ok
    else
      render_unprocessable_entity(message: @emergency.errors)
    end
  end

  private

  def emergency_create_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def emergency_update_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end

  def set_emergency
    @emergency = Emergency.find_by(code: params[:code])

    render_not_found unless @emergency.present?
  end
end
