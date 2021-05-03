require "scripts/twitch_data"
require "scripts/api_keys"
class TwitchDataTest < ActionDispatch::IntegrationTest
    setup do
        ENV['client_secret']=APIKeys.twitch_client_secret
        ENV['client_id']=APIKeys.twitch_client_id
    end
    test "should get twitch data" do
        # only works if there is a current stream
        stream = TwitchData.get_stream(2, "xqcow")
        assert !stream.nil?
        assert !stream.title.nil?
    end
  end