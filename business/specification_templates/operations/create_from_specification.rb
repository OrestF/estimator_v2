class SpecificationTemplates::Operations::CreateFromSpecification < BaseOperation
  attr_reader :specification, :user

  def call
    return fail if [specification, user].any?(&:blank?)

    build_record
    copy_features

    return response(:validation_fail, record: record, errors: record.errors.messages) unless record.valid?

    save_record
    success(record: record)
  end

  private

  def build_record
    @record = SpecificationTemplate.new(title: record_title,
                                        user_id: user.id,
                                        organization_id: specification.organization.id)
  end

  def copy_features
    specification.features.each do |feature|
      record.features.new(feature.slice(:title, :description, :acceptance_criteria, :organization_id).merge!(user_id: user.id))
    end
  end

  def record_title
    "Template from: #{specification.title}"
  end

  def fail
    response(:validation_fail, errors: { specification_id: ['must be present'], user_id: ['must be present'] })
  end
end
