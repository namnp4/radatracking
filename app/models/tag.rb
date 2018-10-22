class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  field :name, type: String, default: ""
  field :selector, type: Hash, default: {}
  field :trigger, type: Hash, default: {}
  field :handle, type: Hash, default: {}
  field :author, type: String, default: ""
end
