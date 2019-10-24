module EstimationsHelper
  def due_estimations_count
    if current_user.worker?
      current_user.estimations.not_done.count
    elsif current_user.manager?
      current_organization.estimations.not_done.count
    elsif current_user.admin?
      Estimation.all.not_done.count
    end
  end

  def estimation_task_form_class(et, css_class)
    "estimation_task_form estimation_task_#{et.id} #{css_class}"
  end
end
