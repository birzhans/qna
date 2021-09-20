class LinksController < ApplicationController
  def destroy
    @id = params[:id]
    @link = Link.find(@id)
    @record = @link.linkable

    if current_user.not_author_of?(@record)
      return redirect_to root_path, notice: 'Restricted access'
    end

    @link.destroy
  end
end
