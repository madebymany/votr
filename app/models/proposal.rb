class Proposal < ActiveRecord::Base
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true
  validates :body, presence: true

  def self.all_with_vote_count
    all.joins('LEFT OUTER JOIN votes ON votes.proposal_id = proposals.id')
       .select("proposals.*, COUNT(votes.id) as votes_size")
       .group("proposals.id")
       .order("votes_size DESC")
  end

  def self.top_with_vote_count
    all_with_vote_count.limit(8)
  end

  def votes_count
    respond_to?(:votes_size) ? votes_size : votes.size
  end

end
