class FilesController < ApplicationController
  def destroy
    @id = params[:id]
    @file = ActiveStorage::Attachment.find(@id)
    @record = @file.record

    return redirect_to root_path, notice: 'Restricted access' if current_user.not_author_of?(@record)

    @file.purge
  end
end
