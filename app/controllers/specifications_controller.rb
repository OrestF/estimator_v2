class SpecificationsController < ResourcesController
  include Specifications::Features

  def index
    respond_to do |format|
      format.html
      format.json { render json: SpecificationDatatable.new(params, **dt_params) }
    end
  end

  def new
    @record = record_class.new
  end

  def create
    if (res = Specifications::Operations::Create.call(record_params: record_params)).success?
      success_nf(MessageHelper.saved(record_class.name), url: project_path(res.data[:record].project))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show; end

  def edit; end

  def update
    if (res = Specifications::Operations::Update.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.updated(record_class.name), url: specification_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  # TODO: create this operation
  def destroy
    if (res = Specifications::Operations::Delete.call(record: record)).success?
      success_nf(MessageHelper.deleted(record_class.name), url: specification_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_class
    Specification
  end

  def record_params
    params.require(:specification).permit!.to_h.merge!(user_id: current_user.id)
  end
end
