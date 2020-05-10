class SpecificationDecorator < ApplicationDecorator
  delegate_all

  def dc_deadline
    ApplicationController.new.render_to_string(partial: 'specifications/components/deadline_chip', locals: { specification: self })
  end
end
