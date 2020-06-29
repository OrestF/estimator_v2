FactoryBot.define do
  factory :specification_template, class: SpecificationTemplate, parent: :specification do
    project_id { nil }
  end
end
