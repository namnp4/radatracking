class TagGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  include TagImportable

  has_many :subs, class_name: "TagGroup"
  belongs_to :parent, class_name: "TagGroup", required: false

  has_and_belongs_to_many :products, class_name: "Product"

  set_importable_tag_sources :parent

  field :code, type: String, default: ""
  validates :code, uniqueness: true
  index({ code: 1 }, { unique: true, name: "code_index" })
 end
