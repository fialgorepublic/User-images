require 'test_helper'

class UserImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_image = user_images(:one)
  end

  test "should get index" do
    get user_images_url
    assert_response :success
  end

  test "should get new" do
    get new_user_image_url
    assert_response :success
  end

  test "should create user_image" do
    assert_difference('UserImage.count') do
      post user_images_url, params: { user_image: { name: @user_image.name } }
    end

    assert_redirected_to user_image_url(UserImage.last)
  end

  test "should show user_image" do
    get user_image_url(@user_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_image_url(@user_image)
    assert_response :success
  end

  test "should update user_image" do
    patch user_image_url(@user_image), params: { user_image: { name: @user_image.name } }
    assert_redirected_to user_image_url(@user_image)
  end

  test "should destroy user_image" do
    assert_difference('UserImage.count', -1) do
      delete user_image_url(@user_image)
    end

    assert_redirected_to user_images_url
  end
end
