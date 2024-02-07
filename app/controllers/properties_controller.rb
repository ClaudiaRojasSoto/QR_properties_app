class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
  end

  def show; end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      @property.generate_qr_code(request.host_with_port)
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :address, :description, :qr_code_url)
  end
end
