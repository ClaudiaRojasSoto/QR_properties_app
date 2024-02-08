class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
  end

  def show
    @map = MapService.initialize_map(@property.address)
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      qr_code_url = QrCodeGeneratorService.call(@property, request.host_with_port)
      @property.update(qr_code_url:)
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @property.update(property_params)
      qr_code_url = QrCodeGeneratorService.call(@property, request.host_with_port)
      @property.update(qr_code_url:)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    qr_file_path = Rails.root.join('public', 'qr_codes', "property_#{@property.id}.png")
    @property.destroy
    FileUtils.rm_f(qr_file_path)
    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :address, :description)
  end
end
