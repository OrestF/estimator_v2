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
    respond_to do |format|
      if (res = Estimations::Operations::Update.call(record: record, record_params: record_params)).success?
        format.json { render json: res.data[:record].attributes.merge!(dc_title: res.data[:record].decorate.dc_title) }
        format.js   { success_nf(MessageHelper.updated(record_class.name), url: estimation_path(record)) }
        format.html { success_nf(MessageHelper.updated(record_class.name), url: estimation_path(record)) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
        format.html { error_nf(html_humanize_errors(res.errors)) }
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

  def destroy
    if (res = Estimations::Operations::Delete.call(record: record)).success?
      success_nf(MessageHelper.deleted(record_class.name), url: estimations_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def evaluate; end

  def toggle
    record.toggle!(:active)

    render json: {
      specification: {
        total_optimistic: record.specification.total_optimistic,
        total_pessimistic: record.specification.total_pessimistic
      }
    }
  end

  private

  def record_class
    Estimation
  end

  def record_params
    params.require(:estimation).permit!.to_h
  end
end
