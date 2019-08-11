# frozen_string_literal: true

class BaseOperation < BaseAction
  attr_reader :form, :record, :record_params

  private

  def build_form
    @form = form_class.new(record_params, record: record)
  end

  def form_valid?
    form.validate
  end

  def assign_attributes
    record.assign_attributes(record_params)
  end

  def record_valid?
    return true if record.errors.none? && record.valid?

    form.sync_errors && false
  end

  def save_record
    yield if record.save && block_given?
  end

  def response(status, *args)
    BaseResponse.new(status, *args)
  end

  def success(*args)
    response(:success, *args)
  end

  def validation_fail(args = {})
    response(:validation_fail, args.merge!(record: record, record_params: record_params, form: form))
  end

  def form_class
    raise 'Define your own form object class in your operation'
  end

  def sync_form_errors
    form.sync_errors_to_form
  end

  def sync_errors_to_record
    form.sync_errors_to_record
  end
end