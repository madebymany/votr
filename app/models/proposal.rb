class Proposal < ActiveRecord::Base
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true
  validates :body, presence: true
end
