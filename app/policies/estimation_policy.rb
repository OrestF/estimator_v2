class EstimationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.worker?
        user.estimations
      elsif user.manager?
        user.organization.estimations
      else
        super
      end
    end
  end

  def index?
    user&.can?(:estimations, :read)
  end
end
