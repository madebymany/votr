class ProposalsController < ApplicationController

  before_filter :fetch_proposal, only: [:show]
  before_filter :authenticate!, only: [:votes]

  def index
    @proposals = Proposal.all.order('RANDOM()')
  end

  def show
    @has_voted = current_user && current_user.voted?(@proposal)
    @vote = Vote.new
  end

  def votes
    @votes = current_user.votes.includes(:proposal)
  end

private

  def fetch_proposal
    @proposal = Proposal.find(params[:id]) or not_found
  end

end