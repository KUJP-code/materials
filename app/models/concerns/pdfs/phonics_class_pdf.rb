# frozen_string_literal: true

module PhonicsClassPdf
  extend ActiveSupport::Concern
  include PdfBackground, PdfBodyItem, PdfFooter, PdfHeaderItem, PdfImage, PdfLinks, PdfList

  included do
    private

    def generate_guide
      Prawn::Document.new(margin: 0, page_size: 'A4',
                          page_layout: :portrait) do |pdf|
        apply_defaults(pdf)
        add_background(pdf, 'phonics')
        draw_header(pdf)
        add_header_image(pdf)
        draw_body(pdf)
        draw_footer(pdf:, level: 'Elementary')
      end
    end

    def draw_header(pdf)
      factory = PdfHeaderItemFactory.new(pdf)
      factory.draw_default_header(text:
        { pre: "#{short_level.upcase} Phonics",
          main: title, sub: goal })
    end

    def add_header_image(pdf)
      factory = PdfImageFactory.new(pdf:, x_pos: 120.mm, width: 70.mm)
      factory.add_image(image: pdf_image, y_pos: 282.mm, height: 46.mm)
    end

    def draw_body(pdf)
      factory = PdfBodyItemFactory.new(pdf)

      factory.draw(text: array_to_list(materials, :number),
                   y_pos: 222.mm, height: 25.mm)
      factory.draw(text: array_to_list(instructions, :number),
                   y_pos: 180.mm, height: 35.mm)
      factory.draw(text: array_to_list(add_difficulty, :dot),
                   y_pos: 133.mm, height: 20.mm)
      factory.draw(text: array_to_list(extra_fun, :dot),
                   y_pos: 103.mm, height: 23.mm)
      factory.draw(text: array_to_list(notes, :dot),
                   y_pos: 70.mm, height: 20.mm)
      factory.draw(text: links_from_hash(links),
                   y_pos: 40.mm, height: 20.mm)
    end
  end
end
