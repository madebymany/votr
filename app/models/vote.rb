class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validate :can_be_voted_for?,
           :not_already_voted,
           :voting_open?,
           :voting_not_closed?

  MAX_VOTES = 8
  OPENS = Time.parse("Thu Aug 28 19:00:00 GMT 2014")
  CLOSES = Time.parse("Thu Sep 11 10:59:59 GMT 2014")

private

  def can_be_voted_for?
    errors.add :base, "You cannot vote for more than #{MAX_VOTES} proposals" unless user.can_vote?
    errors.add :base, "This proposal cannot be voted for" if proposal.closed?
  end

  def not_already_voted
    errors.add :base, "You cannot vote for a proposal more than once" if user.voted?(proposal)
  end

  def voting_not_closed?
    errors.add :base, "The voting window has now closed" if Time.zone.now > CLOSES
  end

  def voting_open?
    errors.add :base, "The voting window is not open yet" if Time.zone.now < OPENS
  end

end
