class BaseResponse
  class NonKeywordArgumentsError < StandardError; end

  DEFAULT_STATUSES = %i[success fail validation_fail].freeze

  DEFAULT_STATUSES.each do |ds|
    define_method("#{ds}?") do
      ds.to_s == status
    end
  end

  attr_reader :status, :args
  def initialize(status, *args)
    @status = status.to_s

    raise NonKeywordArgumentsError if args.present? && !args[0].is_a?(Hash)
    @args = args[0]

    define_singleton_method("#{status}?") do
      true
    end
  end
end
