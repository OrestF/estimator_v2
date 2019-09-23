class ProjectPolicy < ApplicationPolicy
  def new?
    user.can?(:projects, :create) { own_org? }
  end

  def index?
    user.can?(:projects, :read) { own_org? }
  end

  def show?
    user.can?(:projects, :read) { own_org? }
  end

  def create?
    new?
  end

  def update?
    show?
  end

  def destroy?
    user.can?(:projects, :delete) { own_org? }
  end
  alias edit? update?
end
