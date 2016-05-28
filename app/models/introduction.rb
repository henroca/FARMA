class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true

  validates :lo, presence: true

  include AuthenticationAndPosition
  # before_create :default_position
  # validates :title, :content, presence: true
  # private
  #   def default_position
  #     self.position = Time.now
  #   end
end