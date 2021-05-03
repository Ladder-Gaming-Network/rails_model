require "scripts/youtube_data"
require "scripts/api_keys"
class YoutubeDataTest < ActionDispatch::IntegrationTest
    setup do
        ENV['api_key']=APIKeys.youtube_api_key
    end
    test "should get youtube data" do
        channel = YoutubeData.get_channel_info("UCmDTrq0LNgPodDOFZiSbsww")
        assert !channel.nil?
        assert channel.title=="xQcOW"
    end
  end