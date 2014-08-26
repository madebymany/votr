class ProposalsController < ApplicationController

  before_filter :fetch_proposal, only: [:show]
  before_filter :fetch_proposals, only: [:index]
  before_filter :authenticate!, only: [:votes]

  def index
  end

  def show
    @has_voted = current_user && current_user.voted?(@proposal)
    @vote = Vote.new
  end

  def all
    @proposals = Proposal.recent
  end

  def votes
    @votes = current_user.votes.includes(:proposal)
  end

private

  def fetch_proposal
    @proposal = Proposal.recent.find(params[:id]) or not_found
  end

  def fetch_proposals
    @proposals =
      if voting_closed?
        Proposal.top_with_vote_count
      else
        Proposal.recent.order('RANDOM()')
      end
  end

end
