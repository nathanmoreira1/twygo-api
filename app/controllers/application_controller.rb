class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(error)
    render json: { error: I18n.t('errors.messages.not_found') }, status: :not_found
  end
end
