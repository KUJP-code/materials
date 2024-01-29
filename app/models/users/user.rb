# frozen_string_literal: true

class User < ApplicationRecord
  TYPES = %w[Admin Curriculum SchoolManager OrgAdmin Sales Teacher].freeze

  validates :name, presence: true
  validates :type, inclusion: { in: TYPES }

  belongs_to :organisation

  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is?(*types)
    types.include?(type)
  end
end
