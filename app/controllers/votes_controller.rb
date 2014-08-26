class VotesController < ApplicationController

  before_filter :fetch_current_proposal
  before_filter :authenticate!

  def create
    @has_voted = current_user && current_user.voted?(@proposal)
    @vote = Vote.new params_for_create

    if @vote.save
      redirect_to votes_proposals_path
    end
  end

private

  def fetch_current_proposal
    @proposal = Proposal.recent.find params[:proposal_id] || not_found
  end

  def params_for_create
    {
      user: @current_user,
      proposal: @proposal
    }
  end

end
