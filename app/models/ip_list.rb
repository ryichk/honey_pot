class IpList < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: true
  validates :list_type, presence: true, inclusion: { in: %w[blocked trusted] }

  scope :blocked, -> { where(list_type: 'blocked') }
  scope :trusted, -> { where(list_type: 'trusted') }
end
