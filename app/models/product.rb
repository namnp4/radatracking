class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include TagImportable

  has_many :subs, class_name: "Product"
  belongs_to :parent, class_name: "Product", required: false

  has_and_belongs_to_many :tag_groups

  set_importable_tag_sources :parent, :tag_groups

  field :code, type: String, default: ""
  validates :code, uniqueness: true

  index({ code: 1 }, { unique: true, name: "code_index" })

  def self.DEFAULT
    Product.find_or_create_by code: 'topica'
  end
end
