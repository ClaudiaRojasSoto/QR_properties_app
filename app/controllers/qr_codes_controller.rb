class QrCodesController < ApplicationController
  def show
    @property = Property.find(params[:property_id])
  end
end
