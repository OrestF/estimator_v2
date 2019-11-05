class EstimationReportsController < ResourcesController
  def index
    respond_to do |format|
      format.html
      format.json { render json: EstimationReportsDatatable.new(params, **dt_params) }
    end
  end

  def new
    @record = record_class.new
  end

  def create
    if (res = EstimationReports::Operations::Create.call(record_params: record_params)).success?
      success_nf(MessageHelper.saved(record_class.name), url: project_path(res.data[:record].project))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show; end

  def edit; end

  # def update
  #   if (res = EstimationReports::Operations::Update.call(record: record, record_params: record_params)).success?
  #     success_nf(MessageHelper.updated(record_class.name), url: project_path(record))
  #   else
  #     error_nf(html_humanize_errors(res.errors))
  #   end
  # end
  #
  # def destroy
  #   if (res = EstimationReports::Operations::Delete.call(record: record)).success?
  #     success_nf(MessageHelper.deleted(record_class.name), url: projects_path)
  #   else
  #     error_nf(html_humanize_errors(res.errors))
  #   end
  # end

  private

  def record_class
    EstimationReport
  end

  def record_params
    params.require(:estimation_report).permit!.to_h.merge!(user_id: current_user.id)
  end
end
