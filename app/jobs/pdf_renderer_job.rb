class PdfRendererJob < ApplicationJob
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(record)
    @record = record
    pdf_binary = {
      io: StringIO.new(WickedPdf.new.pdf_from_string(plain_html, pdf_options)),
      filename: "Specification_#{record.title}.pdf"
    }

    record.summary_pdf.attach(pdf_binary)

    record.save
  end

  private

  def plain_html
    ActionController::Base.new.render_to_string(
      template: 'specifications/pdf/summary',
      locals: { '@record': @record }
    )
  end

  def pdf_options
    {
      layout: 'pdf.html.erb',
      encoding: 'UTF-8'
    }
  end
end
