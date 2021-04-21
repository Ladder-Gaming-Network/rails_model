class FetchViewcountsJob < ApplicationJob
  queue_as :default

  def perform(twitch_name, stream_id)
    while Stream.where(id: stream_id).exists?
      client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
      client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"
      twitch_client = Twitch::Client.new(
          client_id: client_id,
          client_secret: client_secret
      )
      username = twitch_name
      twitch_id = twitch_client.get_users({login: username}).data.first.id

      stream_info = twitch_client.get_streams({user_id: twitch_id}).data.first
      Viewcount.create(stream_id: stream_id, viewers:stream_info.viewer_count)
      sleep(60)
    end
  end

end
