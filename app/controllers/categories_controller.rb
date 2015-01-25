class CategoriesController < ApplicationController

  def childrens
    @category = Category.find(params[:id])
    respond_to do |format|
      format.json{ render json: @category.childrens }
    end
  end
end