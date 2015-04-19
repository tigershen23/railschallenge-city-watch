class RespondersController < ApplicationController
  def create
    responder = Responder.new(responder_params)

    if responder.save
      render json: responder, status: 201, serializer: responder.active_model_serializer
    else
      render json: { message: responder.errors.as_json }, status: 422
    end

  end

  def index
  end

  def show
  end

  def update
  end

  def new
    not_found
  end

  def edit
    not_found
  end

  def destroy
    not_found
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
