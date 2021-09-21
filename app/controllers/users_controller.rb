class UsersController < ApplicationController
  before_action :authenticate_user!
  def show; end

  def rewards; end
end
