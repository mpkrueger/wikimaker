class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.all
      else
        scope.where(:private => false)
      end
    end
  end

  def show?
    if user.admin?
      true
    elsif user.premium?
      record.public? || record.user == user
    else
      record.public?
    end
  end

end