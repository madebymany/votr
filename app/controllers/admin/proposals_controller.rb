class Admin::ProposalsController < ApplicationController

  inherit_resources
  before_action :authenticate_admin!

  def index
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new params_for_create
    create!
  end

  def edit
  end

  def update
    resource.update_attributes params_for_create
    create!
  end

  def show
  end

private

  def params_for_create
    params.require(:proposal).permit(:title, :author, :body)
  end

end