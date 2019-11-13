class EstimationsController < ResourcesController
  def index
    respond_to do |format|
      format.html
      format.json { render json: EstimationDatatable.new(params, **dt_params) }
    end
  end

  def show; end

  def edit; end

  def create_task
    respond_to do |format|
      if (res = EstimationTasks::Operations::Create.call(record_params: estimation_task_params)).success?
        format.json { render_created(res.data[:record]) }
        format.js   { render_created(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def update_task
    respond_to do |format|
      if (res = EstimationTasks::Operations::Update.call(record: estimation_task, record_params: estimation_task_params)).success?
        format.json { render_updated(res.data[:record]) }
        format.js   { render_updated(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def done
    if (res = Estimations::Operations::Done.call(record: record)).success?
      success_nf(MessageHelper.action('Estimation', 'marked as done'), url: estimation_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_class
    Estimation
  end

  def estimation_task_params
    params.require(:estimation_task).permit!
  end

  def estimation_task
    EstimationTask.find(estimation_task_params[:id])
  end

  def render_created(e_task, _message: nil)
    render 'estimations/task_created', format: :js, status: :ok, locals: { estimation_task: e_task,
                                                                           estimation: record,
                                                                           totals: e_task.estimation.totals }
  end

  def render_updated(e_task, _message: nil)
    render 'estimations/task_updated', format: :js, status: :ok, locals: { estimation_task: e_task,
                                                                           estimation: record,
                                                                           totals: e_task.estimation.totals }
  end
end
