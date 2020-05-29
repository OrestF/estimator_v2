class UsersController < ResourcesController
  def index
    @records = current_organization.users

    respond_to do |format|
      format.html
      format.json do
        render json: UserDatatable.new(params, **dt_params)
      end
    end
  end

  def edit; end

  def update
    if (res = Users::Operations::Update.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.updated(record_class.name), url: organization_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_class
    User
  end

  def record_params
    params.require(:user).permit!.to_h
  end
end
