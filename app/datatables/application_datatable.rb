class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  include Pundit

  def current_user
    options[:current_user]
  end

  def scope
    options[:scope]
  end
end
