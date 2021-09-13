class FilesController < ApplicationController
  def destroy
    @id = params[:id]
    @file = ActiveStorage::Attachment.find(@id)
    @record = @file.record

    if current_user.not_author_of?(@record)
      return redirect_to root_path, notice: 'Restricted access'
    end

    @file.purge
  end
end
