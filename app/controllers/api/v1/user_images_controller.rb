class Api::V1::UserImagesController < Api::V1::BaseController
  before_action :set_user_image, only: %i[ show send_image claim_image]

  def index
    @user_images = current_user.user_images.all
    render json: {success: true, message: "All Images", data: @user_images.collect {|image| user_image(image)}}
  end

  def show
    render json: {success: true, message: "Single Image", data: @user_image.attributes.merge(image: @user_image.pic.attached? ? url_for(@user_image.pic) : '')}
  end

  def create
    @user_image = current_user.user_images.new(user_image_params)
    @user_image.uuid = SecureRandom.uuid
      if @user_image.save
        render json: {success: true, message: "Image created successfully", data: @user_image.attributes.merge(image: @user_image.pic.attached? ?  url_for(@user_image.pic) : '')}
      end
  end

  def send_image
    if @user_image.present? && params[:email].present?
      client = Customerio::APIClient.new('804b58df7d21727da911cd607e7d7c86', region: Customerio::Regions::US)
      request = Customerio::SendEmailRequest.new(
        to: params[:email],
        from: 'team@womboapp.com',
        subject: 'Image link',
        body: "nftmaker://147.182.199.116/api/v1/user_images/#{@user_image.uuid}"
      )
      begin
        response = client.send_email(request)
        if response.code == '200'
          render json: 'image sent'
        end
      rescue Customerio::InvalidResponse => e
        puts e.code, e.message
      end
    end
  end

  def claim_image
    if @user_image.status == false
      if @user_image && @user_image.user_id.present?
        @user_image.update(user_id: @user_image.user.id, status: true)
        render json: {success: true, message: "Image claimed successfully", data: @user_image.attributes.merge(image: @user_image.pic.attached? ?  url_for(@user_image.pic) : '')}
      else
        render json: {success: false, message: "Image not present"}
      end
    else
      render json: {success: false, message: "You have already claimed", data: @user_image.attributes.merge(image: @user_image.pic.attached? ?  url_for(@user_image.pic) : '')}
    end
  end

  private
    def set_user_image
      @user_image = UserImage.find_by(uuid: params[:uuid])
    end

    def user_images
      @user_image = UserImage.find_by(uuid: params[:uuid])
    end

    def user_image_params
      params.require(:user_image).permit(:name, :pic)
    end

    def user_image(image)
      image.attributes.merge(image: image.pic.attached? ?  url_for(image.pic) : '')
    end
end
