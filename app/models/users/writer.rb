# frozen_string_literal: true

class Writer < User
  VISIBLE_TYPES = %w[].freeze

  validate :only_at_ku

  has_many :created_lessons,
           class_name: 'Lesson',
           dependent: :restrict_with_error,
           foreign_key: :creator_id,
           inverse_of: :creator
  has_many :assigned_lessons,
           class_name: 'Lesson',
           dependent: :restrict_with_error,
           foreign_key: :assigned_editor_id,
           inverse_of: :assigned_editor

  private

  def only_at_ku
    errors.add(:organisation, 'must be "KidsUP"') unless organisation&.ku?
  end
end
