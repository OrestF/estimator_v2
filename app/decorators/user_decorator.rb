class UserDecorator < ApplicationDecorator
  delegate_all

  def dc_title
    "#{dc_full_name} | #{email} | #{domain}"
  end

  def dc_full_name
    "#{first_name} #{last_name}"
  end
end
