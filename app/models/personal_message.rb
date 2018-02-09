class PersonalMessage < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  # validates the body 
  validates :body , presence: true
end
