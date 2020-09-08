class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # do we relay need this ??
  end
end
