class SpecificationTemplates::Operations::Create < BaseOperation
  attr_reader :specification, :user

  def call
    return fail if [specification, user].any?(&:blank?)

    create_record
    copy_features

    success(record: record)
  end

  private

  def create_record
    @record = SpecificationTemplate.new(title: record_title,
                                        user_id: user.id,
                                        organization_id: specification.organization.id)
    @record.save(validate: false)
    @record
  end

  def copy_features
    specification.features.each do |feature|
      record.features.new(feature.slice(:title, :description, :acceptance_criteria, :organization_id).merge!(user_id: user.id))
    end

    record.save
  end

  def record_title
    "Template from: #{specification.title}"
  end

  def fail
    response(:validation_fail, errors: { specification_id: ['must be present'], user_id: ['must be present'] })
  end
end
