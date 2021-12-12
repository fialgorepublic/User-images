# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    return render json: {success: false, message: "Invalid email of password", status: 401} if resource.new_record?
    render_resource(resource)
  end

  def respond_to_on_destroy
    head :ok
  end

end
