class EstimationsController < ResourcesController
  include Estimations::EstimationTasks

  def index
    respond_to do |format|
      format.html
      format.json { render json: EstimationDatatable.new(params, **dt_params) }
    end
  end

  def show; end

  def edit; end

  def update
    if (res = Estimations::Operations::Update.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.updated(record_class.name), url: estimation_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def done
    if (res = Estimations::Operations::Done.call(record: record)).success?
      success_nf(MessageHelper.action('Estimation', 'marked as done'), url: estimation_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def destroy
    if (res = Estimations::Operations::Delete.call(record: record)).success?
      success_nf(MessageHelper.deleted(record_class.name), url: estimations_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def evaluate; end

  private

  def record_class
    Estimation
  end

  def record_params
    params.require(:estimation).permit!.to_h
  end
end
