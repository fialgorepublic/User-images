class Api::V1::UserImagesController < Api::V1::BaseController
  before_action :set_user_image, only: %i[ show  ]

  def index
    @user_images = UserImage.all
    render json: {success: true, message: "All Images", data: @user_images.collect {|image| user_image(image)}}
  end

  def show
    render json: {success: true, message: "Single Image", data: @user_image.attributes.merge(image: @user_image.pic.attached? ? url_for(@user_image.pic) : '')}
  end

  def create
    @user_image = UserImage.new(user_image_params)
      if @user_image.save
        render json: {success: true, message: "Image created successfully", data: @user_image.attributes.merge(image: @user_image.pic.attached? ?  url_for(@user_image.pic) : '')}
      end
  end

  private
    def set_user_image
      @user_image = UserImage.find(params[:id])
    end

    def user_image_params
      params.require(:user_image).permit(:name, :pic)
    end

    def user_image(image)
      image.attributes.merge(image: image.pic.attached? ?  url_for(image.pic) : '')
    end
end
