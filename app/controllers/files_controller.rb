class FilesController < ApplicationController
  before_action :set_file
  before_action :authorize!

  def destroy
    @file.purge
  end

  private

  def set_file
    @id = params[:id]
    @file = ActiveStorage::Attachment.find(@id)
    @record = @file.record
  end

  def authorize!
    if current_user.id != @record.user_id
      redirect_to root_path, notice: 'Restricted access'
    end
  end
end
