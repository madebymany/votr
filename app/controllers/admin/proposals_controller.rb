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

  def close
    Proposal.recent.find(params[:proposal_id]).mark_as_closed!
    redirect_to admin_proposals_path
  end

  def open
    Proposal.recent.find(params[:proposal_id]).mark_as_open!
    redirect_to admin_proposals_path
  end

private

  def collection
    @proposals ||= end_of_association_chain.all_with_vote_count
  end

  def params_for_create
    params.require(:proposal).permit(:title, :author, :body)
  end

end
