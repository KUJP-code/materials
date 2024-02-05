# frozen_string_literal: true

class DailyActivity < Lesson
  include Linkable, Steppable

  enum subtype: {
    discovery: 0,
    brain_training: 1,
    dance: 2,
    games: 3,
    imagination: 4,
    life_skills: 5,
    drawing: 6
  }

  private

  def guide_tempfile
    Tempfile.create do |f|
      generate_guide.render_file(f)
      File.open(f)
    end
  end

  def generate_guide
    pdf = Prawn::Document.new

    pdf.text title, size: 24
    pdf.text subtype.capitalize
    pdf.text 'Steps:', size: 18
    steps.each_with_index { |s, i| pdf.text "#{i + 1}. #{s}" }
    pdf.text 'Links:', size: 18
    links.each do |k, v|
      pdf.text "<color rgb='0000FF'><u><link href='#{v}'>#{k}</link></u></color>", inline_format: true
    end

    pdf
  end
end
