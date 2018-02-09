class Conversation < ActiveRecord::Base
 # making author and receiver from the user
 belongs_to :author , class_name: 'User'
 belongs_to :receiver , class_name: 'User'
 # validations of the author
 validates :author , uniqueness: {scope: :receiver}
 # the personal message relation 
 has_many :personal_messages , -> { order(created_at: :asc)} , dependent: :destroy

  # the participating users in messages 
  scope :participating , -> (user) do 
   where("(conversations.author_id = ? OR conversations.receiver_id =?)" , user.id , user.id)
  end
  # the with method 

  def with(current_user) 
   author == current_user ? receiver : author
  end
  
  # the participates method 

  def participates?(user)
   author == user || receiver == user
  end

end
