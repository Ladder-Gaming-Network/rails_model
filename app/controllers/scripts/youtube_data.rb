# frozen_string_literal: true

require_relative('../scripts/api_keys')

class YoutubeData
  def self.get_channel_info(youtube_id)
    api_key = APIKeys.youtube_api_key
    Yt.configure do |config|
      config.api_key = api_key
    end

    return Yt::Channel.new id: youtube_id unless youtube_id.nil?

    nil
  end
end
