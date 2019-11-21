module Specifications::Features
  extend ActiveSupport::Concern

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

  def destroy_feature
    respond_to do |format|
      if (res = Features::Operations::Delete.call(record: feature)).success?
        format.json { render_feature_deleted(res.data[:record]) }
        format.js   { render_feature_deleted(res.data[:record]) }
      else
        format.json { error_nf(html_humanize_errors(res.errors)) }
        format.js   { error_nf(html_humanize_errors(res.errors)) }
      end
    end
  end

  private

  def feature
    Feature.find(feature_params[:id])
  end

  def feature_params
    params.require(:feature).permit!.to_h.merge!(user_id: current_user.id)
  end

  def render_feature_created(feature, _message: nil)
    render 'specifications/features/created', format: :js, status: :ok, locals: { feature: feature,
                                                                                  specification: record }
  end

  def render_feature_updated(feature, _message: nil)
    render 'specifications/features/updated', format: :js, status: :ok, locals: { feature: feature,
                                                                                  specification: record }
  end

  def render_feature_deleted(feature, _message: nil)
    render 'specifications/features/deleted', format: :js, status: :ok, locals: { feature: feature,
                                                                                  specification: record }
  end
end
