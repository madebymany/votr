class Proposal < ActiveRecord::Base
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :body, presence: true

  def self.all_with_vote_count
    all.joins('LEFT OUTER JOIN votes ON votes.proposal_id = proposals.id')
       .select("proposals.*, COUNT(votes.id) as votes_size")
      .where("proposals.created_at >= ?", Date.new(2014,1,1))
       .group("proposals.id")
       .order("votes_size DESC")
  end

  def self.top_with_vote_count
    all_with_vote_count.limit(8)
  end

  def self.recent
    where("created_at >= ?", Date.new(2014,1,1))
  end

  def votes_count
    respond_to?(:votes_size) ? votes_size : votes.size
  end

  def closed?
    closed_at.present?
  end

  def mark_as_closed!
    votes.destroy_all
    self.closed_at = Time.current
    save!(validate: false)
  end

  def mark_as_open!
    self.closed_at = nil
    save!(validate: false)
  end

end
