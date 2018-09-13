class RadaTrack
  include Mongoid::Document
  include Mongoid::Timestamps
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
  field :location, type: String
  # Device's information
  field :client_os, type: String
  # Browser's information
  field :client_browser, type: String
# Who ------------------------------------------------------------------------
  # ID of the registed user who caused the event
  # App user
  field :client_id, type: String
  field :client_user, type: String
  # Page url
  field :url, type: String
  # ID of the unregistered user who caused the event
  # Global user
  # belongs_to :global_user, :class_name => "GlobalUser", :index => true
  # ID of the object who get effected (course, video, ...)
  field :target, type: String
  # Type of track (payment, login, video, ...)
  field :category, type: String
# When ------------------------------------------------------------------------
  field :time_send
  # Behavior
  field :behavior, type: String
  field :value
  field :start_time_on_web
# Other ------------------------------------------------------------------------
  field :extras, type: Hash
end
