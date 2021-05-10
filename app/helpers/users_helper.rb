module UsersHelper
def self.null_blank_input(user)
    if user.stream_link==""
        user.stream_link=nil
    end

    if user.youtube_id==""
        user.youtube_id=nil
    end
end
end
