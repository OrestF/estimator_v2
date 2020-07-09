module Estimations::EstimationTasks
  extend ActiveSupport::Concern

  def create_task
    task_prams = estimation_task_params
    task_prams[:experience_level] = current_user.experience_level.humanize if task_prams[:experience_level].blank?

    respond_to do |format|
      if (res = EstimationTasks::Operations::Create.call(record_params: task_prams)).success?
        format.json { render_task_created(res.data[:record]) }
        format.js   { render_task_created(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def update_task
    respond_to do |format|
      if (res = EstimationTasks::Operations::Update.call(record: estimation_task, record_params: estimation_task_params)).success?
        format.json { render_task_updated(res.data[:record]) }
        format.js   { render_task_updated(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def destroy_task
    respond_to do |format|
      if (res = EstimationTasks::Operations::Delete.call(record: estimation_task)).success?
        format.json { render_task_deleted(res.data[:record]) }
        format.js   { render_task_deleted(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  private

  def estimation_task_params
    params.require(:estimation_task).permit!
  end

  def estimation_task
    EstimationTask.find(estimation_task_params[:id])
  end

  def render_task_created(e_task, _message: nil)
    render 'estimations/estimation_tasks/created', format: :js, status: :ok, locals: { estimation_task: e_task,
                                                                                       estimation: record,
                                                                                       totals: e_task.estimation.totals }
  end

  def render_task_updated(e_task, _message: nil)
    render 'estimations/estimation_tasks/updated', format: :js, status: :ok, locals: { estimation_task: e_task,
                                                                                       estimation: record,
                                                                                       totals: e_task.estimation.totals }
  end

  def render_task_deleted(e_task, _message: nil)
    render 'estimations/estimation_tasks/deleted', format: :js, status: :ok, locals: { estimation_task: e_task,
                                                                                       totals: e_task.estimation.totals }
  end
end
