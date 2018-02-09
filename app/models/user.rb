
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user,:developer ,  :admin]
  after_initialize :set_default_role, :if => :new_record?

  # the author and receiver 

  has_many :authored_conversations , class_name: 'Conversation' , foreign_key: 'author_id' 
  
  has_many :received_conversations , class_name: 'Conversation' , foreign_key: 'received_id'

  # the personal_messages associations 

  has_many :personal_messages , dependent: :destroy
  def set_default_role
    self.role ||= :user
  end
  # the conversation name
  def name
   email.split('@')[0]
  end
end
