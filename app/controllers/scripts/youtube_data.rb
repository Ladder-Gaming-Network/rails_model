# frozen_string_literal: true

class YoutubeData
  def self.get_channel_info(youtube_id)
    api_key = ENV['api_key']
    Yt.configure do |config|
      config.api_key = api_key
    end
    if youtube_id.nil? 
      return nil
    end

    channel= Yt::Channel.new id: youtube_id
    # checks if channel is real or no
    begin   
      channel.title
      return channel
    rescue Yt::Errors::NoItems
      return nil
    end
  end
end
