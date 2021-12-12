class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    return render json: 'please enter params in good format' if params[:user].nil?
    build_resource(sign_up_params)
    resource.save
    unless resource.errors.any?
      sign_in(resource_name, resource)
      render_resource(resource)
    else
      puts resource.errors.full_messages
      render_resource(resource)
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone_no)
  end
end