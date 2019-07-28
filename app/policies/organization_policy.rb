class OrganizationPolicy < ApplicationPolicy
  def index?
    user.can?(:organizations, :read) { own_org? }
  end

  def show?
    index?
  end

  def update?
    user.can?(:organizations, :update) { own_org? }
  end
  alias edit? update?
end
