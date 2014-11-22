class Adress < ActiveRecord::Base
   belongs_to :addressable, polymorphic: true
end
