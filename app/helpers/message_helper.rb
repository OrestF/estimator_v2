# frozen_string_literal: true

module MessageHelper
  def not_authorized
      'You are not authorized to perform this action.'
  end
  module_function :not_authorized

  def updated(resource = 'Data')
    action(resource, 'updated')
  end
  module_function :updated

  def created(resource = 'Data')
    action(resource, 'created')
  end
  module_function :created

  def deleted(resource = 'Data')
    action(resource, 'deleted')
  end
  module_function :deleted

  def saved(resource = 'Data')
    action(resource, 'saved')
  end
  module_function :saved

  def action(resource = 'Data', action = 'saved')
    "#{resource} successfully #{action}"
  end
  module_function :action
end
