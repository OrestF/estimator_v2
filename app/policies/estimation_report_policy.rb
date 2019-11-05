class EstimationReportPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.worker?
        scope.where(id: user.estimation_reports)
      elsif user.manager?
        scope.where(id: user.organization.estimation_reports)
      else
        super
      end
    end
  end

  def new?
    user.can?(:estimation_reports, :create) { own_org? }
  end

  def index?
    user.can?(:estimation_reports, :read) { own_org? }
  end

  def show?
    user.can?(:estimation_reports, :read) { own_org? }
  end

  def create?
    new?
  end

  def update?
    user.can?(:estimation_reports, :update) { own_org? }
  end
  alias edit? update?

  def create_task?
    update?
  end

  def update_task?
    create_task?
  end

  def destroy?
    user.can?(:estimation_reports, :delete) { own_org? }
  end
end
