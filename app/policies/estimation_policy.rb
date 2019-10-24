class EstimationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.worker?
        scope.where(id: user.estimations)
      elsif user.manager?
        scope.where(id: user.organization.estimations)
      else
        super
      end
    end
  end

  def new?
    user.can?(:estimations, :create) { own_org? }
  end

  def index?
    user.can?(:estimations, :read) { own_org? }
  end

  def show?
    user.can?(:estimations, :read) { own_org? }
  end

  def create?
    new?
  end

  def update?
    user.can?(:estimations, :update) { own_org? }
  end
  alias edit? update?

  def create_task?
    update?
  end

  def update_task?
    create_task?
  end

  def destroy?
    user.can?(:estimations, :delete) { own_org? }
  end
end
