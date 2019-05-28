class OrganizationPolicy < ApplicationPolicy
  def update?
    user.manager?
  end
  alias edit? update?
end
