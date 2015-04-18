class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :update]

  def create
    responder = Responder.new(responder_create_params)

    if responder.save
      render json: responder, status: :created, serializer: responder.active_model_serializer
    else
      render_unprocessable_entity(message: responder.errors)
    end
  end

  def index
    render_capacity && return if params[:show] == 'capacity'

    responders = Responder.all

    render json: responders, status: :ok
  end

  def show
    render json: @responder, status: :ok, serializer: @responder.active_model_serializer
  end

  def update
    if @responder.update(responder_update_params)
      render json: @responder, status: :ok
    else
      render_unprocessable_entity(message: @responder.errors)
    end
  end

  private

  def responder_create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def set_responder
    @responder = Responder.find_by(name: params[:name])

    render_not_found unless @responder.present?
  end

  def render_capacity
    capacity = Domain::Reports::CapacityReport.calculate

    render json: { capacity: capacity }, status: :ok
  end
end
