# frozen_string_literal: true

module KUStaffable
  extend ActiveSupport::Concern

  included do
    validate :only_at_ku

    private

    def only_at_ku
      errors.add(:organisation, 'must be "KidsUP"') unless ku?
    end
  end
end
