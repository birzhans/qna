class LinksController < ApplicationController
  def destroy
    @id = params[:id]
    @link = Link.find(@id)
    @record = @link.linkable

    return redirect_to root_path, notice: 'Restricted access' if current_user.not_author_of?(@record)

    @link.destroy
  end
end
