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

  def index?
    user&.can?(:estimations, :read)
  end
end
