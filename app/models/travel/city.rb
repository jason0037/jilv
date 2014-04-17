class Travel::City < ActiveRecord::Base
  belongs_to :country
  has_many :locations
  has_many :merchants
  has_many :products
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :country, existence: true, allow_nil: true
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  cattr_accessor :admin_fields
  self.admin_fields = %w[ country_id name description sequence ]

  def deletable?
    [locations, merchants, products].all?(&:empty?)
  end
end
