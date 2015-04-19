class RespondersController < ApplicationController
  PERMITTED_PARAMS = :type, :name, :capacity

  before_action :check_unpermitted_params, only: [:create]

  def create
    responder = Responder.new(responder_params)

    if responder.save
      render json: responder, status: 201, serializer: responder.active_model_serializer
    else
      render_unprocessable_entity(message: responder.errors.as_json)
    end
  end

  def index
    responders = Responder.all

    render json: responders, status: :ok
  end

  def show
  end

  def update
  end

  def new
    render_not_found
  end

  def edit
    render_not_found
  end

  def destroy
    render_not_found
  end

  private

  def responder_params
    params.require(:responder).permit(PERMITTED_PARAMS)
  end

  def check_unpermitted_params
    unpermitted_params = params[:responder].keys - responder_params.keys
    return if unpermitted_params.empty?

    render_unprocessable_entity(message: "found unpermitted parameter: #{unpermitted_params.first}")
  end
end
