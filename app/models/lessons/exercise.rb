# frozen_string_literal: true

class Exercise < Lesson
  include ExercisePdf, Linkable, Listable, PdfImageable

  ATTRIBUTES = %i[
    add_difficulty
    extra_fun
    pdf_image
    intro
    instructions
    large_groups
    links
    materials
    notes
    outro
    subtype
  ].freeze

  LISTABLE_ATTRIBUTES = %i[
    add_difficulty
    extra_fun
    intro
    instructions
    large_groups
    materials
    notes
    outro
  ].freeze

  enum subtype: {
    aerobics: 0,
    control: 1,
    jumping: 2,
    throwing: 3
  }

  validates :intro, :instructions, presence: true
end
