# frozen_string_literal: true

class TwitchData
  def self.client_link
    
    # link to twitch api via gem
    client_id = Rails.application.credentials.twitch_client_id
    client_secret = Rails.application.credentials.twitch_client_secret
    
    Twitch::Client.new(
      client_id: client_id,
      client_secret: client_secret
    )
  end

  def self.get_stream_info(twitch_name)
    twitch_client = client_link

    # attempt to get stream data
    user_fetch = twitch_client.get_users({ login: twitch_name }).data.first
    unless user_fetch.nil?
      twitch_id = user_fetch.id
      return twitch_client.get_streams({ user_id: twitch_id }).data.first
    end

    nil
  end

  def self.get_stream(user_id, twitch_name)
    twitch_client = client_link
    stream_info = get_stream_info(twitch_name)

    # attempt to get stream data
    user_fetch = twitch_client.get_users({ login: twitch_name }).data.first

    return nil if user_fetch.nil?

    twitch_id = user_fetch.id
    stream_info = twitch_client.get_streams({ user_id: twitch_id }).data.first

    # if not live, quit
    return nil if stream_info.nil?

    fetched_stream = Stream.where(id: stream_info.id).first
    if fetched_stream.nil?
      # if stream id has changed, destroy last stream + viewcounts
      stream_to_delete = Stream.where(user_id: user_id).first
      unless stream_to_delete.nil?
        Viewcount.where(stream_id: stream_to_delete.id).destroy_all
        stream_to_delete.destroy
      end
      Stream.create(id: stream_info.id, user_id: user_id, title: stream_info.title)
    else
      # otherwise, just continue
      fetched_stream
    end
  end

  # should return a list of user ids that are followed by user and are live
  def self.get_live_followed(user)
    live_ids = []

    user.following.each do |followed|
      next if followed.stream_link.nil?

      stream_info = get_stream_info(followed.stream_link[11..])
      live_ids.append(followed.id) unless stream_info.nil?
    end

    live_ids
  end
end
