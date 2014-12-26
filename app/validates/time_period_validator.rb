class TimePeriodValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.present? && record.send(options[:scope]).present? && value < record.send(options[:scope])
    record.errors.add attribute, options[:message] || 'Invalid Time Period'
    record.errors.add options[:scope], options[:message] || 'Invalid Time Period'
  end
end
