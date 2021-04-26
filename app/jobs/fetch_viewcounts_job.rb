class FetchViewcountsJob < ApplicationJob
  queue_as :default

  def perform()

    while Stream.where(tracked: true).count > 0 do
      Stream.where(tracked: true).each do |stream|
        #init client
        client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
        client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"
        twitch_client = Twitch::Client.new(
            client_id: client_id,
            client_secret: client_secret
        )

        #spawn viewcounts
        username = User.where(id:stream.user_id).first.stream_link[11..]
        twitch_id = twitch_client.get_users({login: username}).data.first.id

        stream_info = twitch_client.get_streams({user_id: twitch_id}).data.first
        Viewcount.create(stream_id: stream.id, viewers:stream_info.viewer_count)
      end
      sleep(60)
    end
  end

end
