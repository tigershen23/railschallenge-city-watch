class Responder < ActiveRecord::Base
  # See config/initializers/load_responder_types.rb for subclass declaration
  TYPES = %w(Fire Police Medical)

  belongs_to :emergency, foreign_key: :emergency_code, primary_key: :code

  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: 1..5
  validates :type, presence: true

  scope :available, -> { where(emergency_code: nil) }
  scope :on_duty, -> { where(on_duty: true) }
  scope :able_to_respond, -> { available.merge(on_duty) }
  # Declare scopes for each type, e.g. Responder.fires, Responder.medicals
  TYPES.each { |type| scope type.downcase.pluralize, -> { where(type: type) } }

  def self.scope_capacity(scope)
    send(scope.to_s).sum_capacity
  end

  # returns a Hash with keys being Responder ID's
  # and values being their corresponding capacity
  def self.able_to_respond_capacities
    capacities = {}
    able_to_respond.pluck(:id, :capacity).each do |id, capacity|
      capacities[id] = capacity
    end

    capacities
  end

  def self.sum_capacity
    sum(:capacity)
  end

  def self.type_scope(type)
    type.downcase.pluralize
  end
end
