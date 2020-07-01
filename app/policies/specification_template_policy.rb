class SpecificationTemplatePolicy < SpecificationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      super
    end
  end

  def create_from_specification?
    create?
  end
end
