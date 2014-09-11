class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true
  belongs_to :ticket, foreign_key: 'votable_id', class_name: 'Ticket'
end
