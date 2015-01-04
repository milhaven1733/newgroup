=begin
Ransack.configure do |config|
  config.add_predicate 'time_lteq',
    arel_predicate: 'lteq',
    formatter: proc { |v| v },
    validator: proc { |v| v.present? },
    type: :string 
  config.add_predicate 'time_gteq',
    arel_predicate: 'gteq',
    formatter: proc { |v| v },
    validator: proc { |v| v.present? },
    type: :string 
  config.add_predicate 'date_lteq',
    arel_predicate: 'lteq',
    formatter: proc { |v| v.to_date },
    validator: proc { |v| v.present? },
    type: :string 
  config.add_predicate 'date_gteq',
    arel_predicate: 'gteq',
    formatter: proc { |v| v.to_date },
    validator: proc { |v| v.present? },
    type: :string 
end
=end
