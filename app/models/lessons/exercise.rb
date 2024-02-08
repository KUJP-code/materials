# frozen_string_literal: true

class Exercise < Lesson
  include ExercisePdf, Linkable, Listable, PdfImageable

  LISTABLE_ATTRIBUTES = %i[
    add_difficulty
    extra_fun
    intro
    instructions
    large_groups
    materials
    notes
    outro
    steps
  ].freeze

  PDF_IMAGEABLE_ATTRIBUTES = %i[guide_image].freeze

  before_validation :listify_attributes

  validates :intro, :instructions, presence: true

  has_one_attached :guide_image
end
