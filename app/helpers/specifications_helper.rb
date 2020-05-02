module SpecificationsHelper
  def deadline_chip_color(deadline)
    return 'default' if deadline.blank?
    return 'danger' if Time.current > (deadline - 1.hours)
    return 'warning' if Time.current > (deadline - 8.hours)

    'default'
  end
end
