class SpecificationsController < ResourcesController
  skip_before_action :verify_record, :authenticate_user!, only: :sign_off_request

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
      success_nf(MessageHelper.saved(record_class.name), url: specification_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Specification #{@record.title}",
               page_size: 'A4',
               template: 'specifications/pdf/summary.html',
               layout: 'pdf.html',
               orientation: 'Landscape',
               lowquality: false,
               zoom: 1,
               dpi: 75
      end
    end
  end

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
      success_nf(MessageHelper.deleted(record_class.name), url: specifications_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def send_for_sign_off
    if (res = Specifications::Operations::SendForSignOff.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.action('Specification', 'sent'), url: specification_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def sign_off_request
    @hide_header = true
    @hide_breadcrumbs = true

    authorize_client
    verify_record
  end

  def sign_off
    if (res = Specifications::Operations::SignOff.call(record: record, record_params: { signed_off_by: current_user })).success?
      success_nf(MessageHelper.action('Specification', 'signed off'), url: request.referrer)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def assign_estimators
    if (res = Specifications::Operations::AssignEstimators.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.action('Estimators assigned', ''), url: specification_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def finish
    if (res = Specifications::Operations::Finish.call(record: record)).success?
      success_nf(MessageHelper.action('Specifications', 'marked as finished'), url: specification_path(record))
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

  def authorize_client
    raise Pundit::NotAuthorizedError unless (u = Auth.authenticate_basic(params[:client_auth]))

    sign_in u
  end
end
