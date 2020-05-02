class SoftDeletable < Module
  def initialize(dependant_relations:)
    define_method('dependant_relations') { Array.wrap(dependant_relations) }
  end

  def included(base)

    base.class_eval do
      default_scope -> { where(deleted_at: nil) }

      def deleted?
        !deleted_at.nil?
      end

      def destroy
        return if deleted?

        self.deleted_at = Time.current
        save(valdiate: false)

        soft_delete_relations
      end
      alias delete destroy

      def soft_delete_relations
        ApplicationRecord.transaction do
          dependant_relations.each do |dr|
            relations = send(dr)
            if relations.respond_to?(:update_all)
              relations.each(&:delete)
            else
              relations.delete
            end
          end
        end
      end

      def restore_relations
        ApplicationRecord.transaction do
          dependant_relations.each do |dr|
            relations = send(dr).unscoped
            if relations.respond_to?(:update_all)
              relations.each { |r| r.try(:restore) }
            else
              relations.try(:restore)
            end
          end
        end
      end

      def restore
        return unless deleted?

        self.deleted_at = nil
        save(valdiate: false)

        restore_relations
      end
    end
  end
end
