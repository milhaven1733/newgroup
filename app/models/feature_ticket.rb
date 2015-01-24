class FeatureTicket < ActiveRecord::Base
  belongs_to :ticket

  mount_uploader :slider_image, SliderUploader
end
