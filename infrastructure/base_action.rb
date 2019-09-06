class BaseAction
  class NonKeywordArgumentsError < StandardError; end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  attr_reader :args
  def initialize(*args, &block)
    raise NonKeywordArgumentsError if args.present? && !args[0].is_a?(Hash)

    @args = @data = args[0]
    @args.each do |name, value|
      instance_variable_set("@#{name}", value)
    end

    block.call if block_given?
  end

  def call; end
end
