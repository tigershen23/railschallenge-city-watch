class ApplicationController < ActionController::API
  def render_not_found
    error = { message: 'page not found' }.to_json
    render json: error, status: 404
  end

  def render_unprocessable_entity(message:)
    render json: { message: message }, status: :unprocessable_entity
  end
end
