class AttachmentsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @attachment = Attachment.find(params[:id])
    respond_to do |format|
      format.html{ head :no_content }
      format.json{ head :no_content }
    end
  end
end