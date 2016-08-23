class Question < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :exercise, counter_cache: true
  has_many :tips
  has_many :answers

  validates :correct_answer, presence: true
end
