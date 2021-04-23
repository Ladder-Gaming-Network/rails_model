# frozen_string_literal: true

class TwitchReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes

  def chart

    #update viewcounts for particular stream
    client_id = "70z1l0mo2xuyv7ujj5q3gy4pmuktk6"
    client_secret = "1lfolprd26gv90uaxj3bxb2x10csju"
    twitch_client = Twitch::Client.new(
        client_id: client_id,
        client_secret: client_secret
    )
    username = element.dataset[:username]
    twitch_id = twitch_client.get_users({login: username}).data.first.id

    stream_info = twitch_client.get_streams({user_id: twitch_id}).data.first
    Viewcount.create(stream_id:element.dataset[:twitch_id], viewers:stream_info.viewer_count)
    
    #broadcast signal for chart change
    #cable_ready["timeline"].text_content(
    #  selector: "text-body",
    #  text: "Hello."
    #)
    #cable_ready.broadcast

  end

end
