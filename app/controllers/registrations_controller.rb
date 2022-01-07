class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def create
    build_resource(sign_up_params)
    resource.save
    render json: resource, status: :created
  end
end
