class SpecificationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.worker?
        scope.where(id: user.specifications)
      elsif user.organization_manager?
        scope.where(id: user.organization.specifications)
      else
        super
      end
    end
  end

  def new?
    user.can?(:specifications, :create) { own_org? }
  end

  def index?
    user.can?(:specifications, :read) { own_org? }
  end

  def show?
    user.can?(:specifications, :read) { own_org? }
  end

  def create?
    new?
  end

  def update?
    user.can?(:specifications, :update) { own_org? }
  end
  alias edit? update?

  def create_task?
    update?
  end

  def update_task?
    create_task?
  end

  def destroy?
    user.can?(:specifications, :delete) { own_org? }
  end
end
