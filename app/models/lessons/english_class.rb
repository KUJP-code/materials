# frozen_string_literal: true

class EnglishClass < Lesson
  include Listable, PdfUploadable

  ATTRIBUTES = %i[example_sentences guide lesson_topic notes term unit vocab].freeze
  LISTABLE_ATTRIBUTES = %i[example_sentences notes vocab].freeze

  attr_accessor :lesson_topic, :term, :unit

  before_validation :set_topic

  validates :example_sentences, :vocab, presence: true
  with_options if: proc { |l| l.topic.nil? } do
    validates :lesson_topic, presence: true
    validates :term, inclusion: { in: (1..3).map(&:to_s) }
    validates :unit, inclusion: { in: (1..20).map(&:to_s) }
  end

  private

  def set_topic
    self.topic = "Term #{term} Unit #{unit} - #{lesson_topic}"
  end
end
