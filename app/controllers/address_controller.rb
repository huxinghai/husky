class AddressController < ApplicationController

  def cities
    @cities = City.where(:province_id => params[:province_id])
    respond_to do |format|
      format.json{ render json: @cities }
    end
  end

  def provinces
    @provinces = Province.all
    respond_to do |format|
      format.json{ render json: @provinces }
    end
  end
end