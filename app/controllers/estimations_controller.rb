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
        format.json { render_response(res.data[:record], message: 'success') }
        format.js   { render_response(res.data[:record], message: 'success') }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def update_task
    respond_to do |format|
      if (res = EstimationTasks::Operations::Update.call(record: estimation_task, record_params: estimation_task_params)).success?
        format.json { success_nf(MessageHelper.updated) }
        format.js   { success_nf(MessageHelper.updated) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
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

  def render_response(e_task, message: nil)
    render 'estimations/task_created', format: :js, status: :ok, locals: { estimation_task: e_task, estimation: record }
  end
end
