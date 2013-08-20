class User < ActiveRecord::Base
  has_many :votes

  def votes_remaining
    Vote::MAX_VOTES - votes.size
  end

  def can_vote?
    votes.size < Vote::MAX_VOTES
  end

  def voted?(proposal)
    votes.where(proposal_id: proposal.id).any?
  end

  def self.from_omniauth(auth)
    where(twitter_uid: auth["uid"]).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.twitter_uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.twitter_username = auth["info"]["nickname"]
    end
  end


end
