# frozen_string_literal: true

class RegenerateGuidesJob < ApplicationJob
  queue_as :default

  def perform(lesson)
    lesson.attach_guide
  end
end
