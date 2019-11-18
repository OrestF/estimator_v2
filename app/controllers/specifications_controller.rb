class SpecificationsController < ResourcesController
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

  def destroy
    if (res = Specifications::Operations::Delete.call(record: record)).success?
      success_nf(MessageHelper.deleted(record_class.name), url: specification_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def create_feature
    respond_to do |format|
      if (res = Features::Operations::Create.call(record_params: feature_params)).success?
        format.json { render_feature_created(res.data[:record]) }
        format.js   { render_feature_created(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  def update_feature
    respond_to do |format|
      if (res = Features::Operations::Update.call(record: feature, record_params: feature_params)).success?
        format.json { render_feature_updated(res.data[:record]) }
        format.js   { render_feature_updated(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  private

  def record_class
    Specification
  end

  def feature
    Feature.find(feature_params[:id])
  end

  def feature_params
    params.require(:feature).permit!.to_h.merge!(user_id: current_user.id)
  end

  def record_params
    params.require(:specification).permit!.to_h.merge!(user_id: current_user.id)
  end

  def render_feature_created(feature, _message: nil)
    render 'specifications/feature_created', format: :js, status: :ok, locals: { feature: feature,
                                                                                 specification: record }
  end

  def render_feature_updated(feature, _message: nil)
    render 'specifications/feature_updated', format: :js, status: :ok, locals: { feature: feature,
                                                                                 specification: record }
  end
end
