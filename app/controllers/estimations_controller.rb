class EstimationsController < ResourcesController
  def index
    respond_to do |format|
      format.html
      format.json { render json: EstimationDatatable.new(params, **dt_params) }
    end
  end

  def show; end

  def edit; end

  private

  def record_class
    Estimation
  end

  def record_params
    params.require(:project).permit!.to_h.merge!(user_id: current_user.id,
                                                 organization_id: current_organization.id)
  end
end
