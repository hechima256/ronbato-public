class HomeController < ApplicationController
    def top
        if user_signed_in?
            redirect_to topics_path
        end
    end
    def terms

    end
end
