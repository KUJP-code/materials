# frozen_string_literal: true

module WatermarkHelper
  def watermark_for_user(user)
    if user.organisation_id.nil? || user.organisation_id != 1
      Rails.root.join('app/assets/icons/watermark_ku.pdf')
    else
      Rails.root.join('app/assets/icons/watermark_vision.pdf')
    end
  end
end
