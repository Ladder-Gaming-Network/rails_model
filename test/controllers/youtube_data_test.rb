require "scripts/youtube_data"
class YoutubeDataTest < ActionDispatch::IntegrationTest
    setup do
      
    end
    test "should get youtube data" do
        channel = YoutubeData.get_channel_info("UCmDTrq0LNgPodDOFZiSbsww")
        assert !channel.nil?
        assert channel.title=="xQcOW"
    end
  end