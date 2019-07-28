class ProjectPolicy < ApplicationPolicy
  def index?
    user.can?(:projects, :read) { own_org? }
  end

  def show?
    user.can?(:projects, :read) { own_org? }
  end

  def update?
    show?
  end
  alias edit? update?
end
