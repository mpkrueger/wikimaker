class Wiki < ActiveRecord::Base
  belongs_to :user

  def public?
    !private?
  end
end
