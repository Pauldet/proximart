class ExhibitionsController < ApplicationController

  def index
    @exhibitions = Exhibition.all
  end
end
