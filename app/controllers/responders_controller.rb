class RespondersController < ApplicationController
  CREATE_PERMITTED_PARAMS = 'type', 'name', 'capacity'
  UPDATE_PERMITTED_PARAMS = ['on_duty']
  PERMITTED_PARAMS = CREATE_PERMITTED_PARAMS | UPDATE_PERMITTED_PARAMS

  before_action :check_create_params, only: :create
  before_action :check_update_params, only: :update

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
    responder = Responder.find_by(name: params[:name])

    render_not_found and return unless responder.present?

    render json: responder, status: :ok
  end

  def update
    responder = Responder.find_by(name: params[:name])

    if responder.update(responder_params)
      render json: responder, status: :ok
    else
      render_unprocessable_entity(message: responder.errors.as_json)
    end
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

  def check_create_params
    filter_unpermitted_params(permitted_params: CREATE_PERMITTED_PARAMS)
  end

  def check_update_params
    filter_unpermitted_params(permitted_params: UPDATE_PERMITTED_PARAMS)
  end

  def filter_unpermitted_params(permitted_params:)
    unpermitted_params = params[:responder].keys - permitted_params

    return if unpermitted_params.empty?

    render_unprocessable_entity(message: "found unpermitted parameter: #{unpermitted_params.first}")
  end
end
