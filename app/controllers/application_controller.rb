class ApplicationController < ActionController::API
  rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_parameters

  def render_not_found
    error = { message: 'page not found' }
    render json: error, status: 404
  end

  protected

  def render_unprocessable_entity(message:)
    render json: { message: message }, status: :unprocessable_entity
  end

  def render_unpermitted_parameters(error)
    render_unprocessable_entity(message: error.message)
  end
end
