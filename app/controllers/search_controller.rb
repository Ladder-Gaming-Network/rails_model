class SearchController < ApplicationController
    def search()
        @users=User.all()
        if !params["query"].blank?
          searched_users=User.search(params["query"])
          if searched_users.size>0
            $users=searched_users
            $new_users_search=TRUE 
          else  
            flash[:danger] = "Your search returned no results"
          end
        end
        redirect_to "/users" 
    end
end
