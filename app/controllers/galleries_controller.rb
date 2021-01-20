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
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def gallery_params
    params.require(:gallery).permit(:image_title, :image_description, :image, :category, :item_for_sale)
  end
end
