class UserPolicy < ApplicationPolicy
  def index?
    user.can?(:users, :read) { own_org? }
  end

  def show?
    user.can?(:users, :read) { own_org? }
  end

  def update?
    user.can?(:users, :update) { own_org? && current_organization.users.include?(record) }
  end
  alias edit? update?
end
