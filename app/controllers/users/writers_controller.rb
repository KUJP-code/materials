# frozen_string_literal: true

class WritersController < UsersController
  def show
    redirect_to courses_path
  end
end