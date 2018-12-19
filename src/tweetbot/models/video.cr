class Video < Granite::Base
  adapter pg
  field channel_id : String
  field video_id : String
end