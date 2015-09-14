require 'test_helper'

class ConvertersControllerTest < ActionController::TestCase
  setup do
    @converter = converters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:converters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create converter" do
    assert_difference('Converter.count') do
      post :create, converter: { name: @converter.name, file: Rack::Test::UploadedFile.new(File.join('public/uploads/converter/example/books.xml')), extension: 'csv' }
    end

    assert_redirected_to converter_path(assigns(:converter))
  end

  test "should show converter" do
    get :show, id: @converter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @converter
    assert_response :success
  end

  test "should update converter" do
    patch :update, id: @converter, converter: { name: @converter.name, file: Rack::Test::UploadedFile.new(File.join('public/uploads/converter/example/data.json')), extension: 'csv' }
    assert_redirected_to converter_path(assigns(:converter))
  end

  test "should destroy converter" do
    assert_difference('Converter.count', -1) do
      delete :destroy, id: @converter
    end

    assert_redirected_to converters_path
  end
end
