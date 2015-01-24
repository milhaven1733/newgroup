# encoding: utf-8

class SliderUploader < BaseUploader
  process :resize_to_fill => [870, 490]
end
