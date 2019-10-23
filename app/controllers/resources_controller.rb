class ResourcesController < ApplicationController
  before_action :verify_class, only: %i[index new create]
  before_action :verify_record, except: %i[index new create]

  protected

  def record
    @record ||= record_class.find(params[:id])
  end

  def verify_record
    authorize_with_configs(record)
  end

  def verify_class
    authorize_with_configs(record_class)
  end

  def authorize_with_configs(record, configs = {})
    return true if policy_class.new(current_user,
                                    record,
                                    configs.merge!(current_organization: current_organization)).send("#{action_name}?")

    raise Pundit::NotAuthorizedError, "not allowed to #{action_name} #{record.inspect}"
  end

  def policy_class
    "#{record_class}Policy".constantize
  end

  def dt_params
    { current_user: current_user, current_organization: current_organization, policy_class: policy_class }
  end
end
