class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant
  before_action :authenticate

  # GET /photos
  # GET /photos.json
  def index
    @photos = @restaurant.photos
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @restaurant.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to restaurant_photos_path, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to [@restaurant, @photo], notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
      @photo = Photo.find(params[:id])
    end

  def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
      params.require(:photo).permit(:image)
    end

    def authenticate
      if !user_signed_in? || !@restaurant.belongsToUser?(current_user) || current_user.role == 1
        redirect_to(@restaurant, alert: "No tiene permiso")
      end
    end
end
