class Wiki < ActiveRecord::Base
  belongs_to :user
   has_many :collaborators
   has_many :users, through: :collaborators

   scope :visible_to, lambda { |user| user.role == "premium" ? scoped : where(private: false) } 
  
   
end
