class Specifications::Operations::SignOff < BaseOperation
  def call
    if record.client_sign_off?
      assign_timestamp
      update_state
    end

    success(args)
  end

  private

  def assign_timestamp
    record.signed_off_at = Time.current
  end

  def update_state
    record.qa!
  end
end
