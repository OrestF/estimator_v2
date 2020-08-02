class ApplicationPolicy
  attr_reader :user, :record, :configs, :current_organization

  def initialize(user, record, configs = {})
    @user = user
    @record = record
    @configs = configs
    @current_organization = @configs[:current_organization] || try(:current_organization)
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  protected

  def own_org?
    return false if current_organization.blank?

    current_organization == user.organization
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(organization_id: user.organization.id)
    end
  end
end
