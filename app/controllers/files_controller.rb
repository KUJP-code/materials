class FilesController < ApplicationController
  layout :resolve_layout
  include WatermarkHelper

  before_action :set_file, only: %i[show destroy]
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @files = policy_scope(ActiveStorage::Blob,
                          policy_scope_class: FilePolicy::Scope)
             .order(byte_size: :desc).limit(100)
  end

  def show
    # Increment download count (optional)
    @file.update(download_count: @file.download_count + 1)
    file_data = @file.download
    content_type = @file.content_type
    file_data = add_watermark(file_data) if content_type == 'application/pdf'

    send_data file_data,
              filename: @file.filename.to_s,
              disposition: 'inline'
  end

  def destroy
    attachment = @file.attachments.find_by(record_id: params[:record_id],
                                           record_type: params[:record_type])
    attachment.purge
    redirect_back fallback_location: root_path,
                  notice: 'File deleted.'
  end

  private

  def add_watermark(file_data)
    pdf = CombinePDF.parse(file_data)
    watermark = CombinePDF.load(watermark_for_user(current_user))
    pdf.pages.each do |page|
      page << watermark.pages.first
    end
    file_data = pdf.to_pdf
  end

  def resolve_layout
    case action_name
    when 'show'
      'file'
    when 'index'
      'application'
    end
  end

  def set_file
    @file = authorize(ActiveStorage::Blob.find(params[:id]),
                      policy_class: FilePolicy)
  end
end
