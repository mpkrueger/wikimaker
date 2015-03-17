class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, class_name: 'User'

  def public?
    !private?
  end
end
