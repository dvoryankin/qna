class Attachment < ApplicationRecord
  belongs_to :attachable, optional: true, polymorphic: true

  mount_uploader :file, FileUploader

  validates :file, presence: true
  validate :file_size_validation

  private

  def file_size_validation
    return unless file.present? && file.file.present?

    if file.file.size > 10.megabytes
      errors.add(:file, 'size should be less than 10MB')
    end
  end
end