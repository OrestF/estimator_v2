class DbConnect
  def self.call(organization,  &block)
    @organization = organization
    result = ApplicationRecord.connected_to(database: db_name) { block.call }

    reset_connection

    result
  end

  def self.reset_connection
    ApplicationRecord.connected_to(database: :primary) {}
  end

  private

  def self.db_name
    return :primary if @organization.name == 'primary'

    "#{@organization.name}_organization".underscore.to_sym
  end
end