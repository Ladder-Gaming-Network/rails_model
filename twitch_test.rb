require "twitch-api"

@client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
@client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"

previous_view_count = 0

while true do
    @twitch_client = Twitch::Client.new(
        client_id: @client_id,
        client_secret: @client_secret

        ## this is default
        # token_type: :application,

        ## this can be required by some Twitch end-points
        # scopes: scopes,

        ## if you already have one
        # access_token: access_token
    )

    username = "ludwig"
    twitch_id = @twitch_client.get_users({login: username}).data.first.id

    stream_info = @twitch_client.get_streams({user_id: twitch_id}).data.first
    if stream_info.viewer_count != previous_view_count then
        puts("Data for Twitch streamer: " + username)
        puts("Title: " + stream_info.title)
        puts("View count: " + stream_info.viewer_count.to_s)
        previous_view_count = stream_info.viewer_count
        Viewcount.create!(stream_id:1, viewers:stream_info.viewer_count)
    end
    sleep(60)
    puts("-----")
end