require "scripts/twitch_data"
class TwitchDataTest < ActionDispatch::IntegrationTest
    setup do
      
    end
    test "should get twitch data" do
        # only works if there is a current stream
        stream = TwitchData.get_stream(2, "xqcow")
        assert !stream.nil?
        assert !stream.title.nil?
    end
  end