class ApplicationController < ActionController::API
  def not_found
    error = { message: 'page not found' }.to_json
    render json: error, status: 404
  end
end
