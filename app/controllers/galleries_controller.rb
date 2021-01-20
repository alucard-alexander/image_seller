class GalleriesController < ApplicationController
  before_action :set_gallery, only: %i[show edit update destroy]
  skip_before_action :validate_otp_verified, only: %i[otp_confirmed_check otp_validate]


  def index
    @galleries = Gallery.all
  end

  def show; end

  def new
    @gallery = Gallery.new
  end

  def edit; end

  def otp_confirmed_check; end

  def otp_validate
    if current_user.otp == params[:otp].to_i
      logged_in_user = current_user
      logged_in_user.otp_verified = true
      logged_in_user.save
      redirect_to galleries_path
    else
      redirect_to otp_confirmed_check_path
    end
  end

  # POST /galleries
  def create
    binding.pry
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      ImagePrice.create(gallery_id: @gallery.id, price: params[:image_price])
      redirect_to galleries_path, notice: 'Gallery was successfully created.'
    else
      render :new
    end
  end

  def update
    if @gallery.update(gallery_params)
      redirect_to galleries_path, notice: 'Gallery was successfully updated.' 
    else
      render :edit 
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_url, notice: 'Gallery was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def gallery_params
    params.require(:gallery).permit(:image_title, :image_description, :image, :category, :item_for_sale, :image_price)
  end
end
