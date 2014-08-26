class TimePeriodValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.present? && record.send(options[:scope]).present? && value < record.send(options[:scope])
      record.errors.add attribute, options[:message]||"时间周期非法"
      record.errors.add options[:scope], options[:message]||"时间周期非法"
    end
  end

end
