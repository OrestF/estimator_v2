# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_collection(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        next if value.blank?

        results = if value.is_a?(String) && value.start_with?('without_')
                    results.public_send(value)
                  else
                    results.public_send(key, value)
                  end
      end
      results.distinct
    end
  end
end
