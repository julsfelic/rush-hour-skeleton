class Client < ActiveRecord::Base

  has_many :payload_requests
  has_many :ip_addresses,    through: :payload_requests
  has_many :referrers,       through: :payload_requests
  has_many :resolutions,     through: :payload_requests
  has_many :url_requests,    through: :payload_requests
  has_many :user_agents,     through: :payload_requests
  has_many :verbs,           through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url,   presence: true

end
