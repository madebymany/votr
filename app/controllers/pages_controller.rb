class PagesController < ApplicationController

  before_filter :fetch_proposals, only: [:index]

  def index
  end

  def conduct
  end

end
