class GlobalTrack
  include Mongoid::Document
  include Mongoid::Timestamps

# For internal ---------------------------------------------------------------
  # Version of tracking system
  field :tracker_version, type: String, default: Constants::TRACKER_VERSION
  # Version of tracking client
  field :client_version, type: String

# From where (application, context) ------------------------------------------
  # Application where behavior occurred (pedia, native, ...)
  field :app_name, type: String
  # Application/API version
  field :app_version, type: String
  # Referer
  field :referer, type: String

# From which (device) --------------------------------------------------------
  # IP address of device
  field :ip, type: String
  # Location
  field :location, type: Hash
  # Device's information
  field :device, type: Hash
  # Browser's information
  field :browser, type: Hash

# Who ------------------------------------------------------------------------
  # ID of the registed user who caused the event
  # App user
  field :user, type: String
  # ID of the unregistered user who caused the event
  # Global user
  # belongs_to :global_user, :class_name => "GlobalUser", :index => true
  # ID of the object who get effected (course, video, ...)
  field :target, type: String
  # Type of track (payment, login, video, ...)
  field :category, type: String
  # Behavior
  field :behavior, type: String
  # Page url
  field :url, type: String

# What ------------------------------------------------------------------------
  # Content of tracking event
  field :extras, type: Hash

  field :session_id, type: String

  # Indexing
  # index({ created_at: 1 }, { name: "created_at_index" })
  # index({ category: 1 }, { name: "category_index" })
  # index({ target: 1 }, { name: "target_index" })
  # index({ user: 1 }, { name: "user_index" })

end
