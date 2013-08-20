class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validate :can_be_voted_for?,
           :not_already_voted,
           :within_vote_window?

  MAX_VOTES = 8
  CLOSES = Time.parse("Fri Aug 30 11:59:59 GMT 2013")

private

  def can_be_voted_for?
    errors.add :base, "You cannot vote for more than #{MAX_VOTES} proposals" unless user.can_vote?
  end

  def not_already_voted
    errors.add :base, "You cannot vote for a proposal more than once" if user.voted?(proposal)
  end

  def within_vote_window?
    errors.add :base, "The voting window has now closed" if Time.current > CLOSES
  end

end
