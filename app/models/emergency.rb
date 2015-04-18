class Emergency < ActiveRecord::Base
  has_many :responders, foreign_key: :emergency_code, primary_key: :code

  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity,
            presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :fully_responded_to, -> { where(full_response: true) }

  def self.full_responses_count
    fully_responded_to.count
  end

  # 'Fire' --> 'fire_severity'
  def type_severity(type)
    send("#{type.to_s.downcase}_severity")
  end
end
