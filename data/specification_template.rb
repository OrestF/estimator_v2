class SpecificationTemplate < Specification
  self.table_name = 'specifications'

  default_scope { unscoped.where(project_id: nil) }
end
