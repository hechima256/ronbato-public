class ApplicationController < ActionController::Base
    # before_action :configure_permitted_parameters, if: :devise_controller?

    def authenticate!
        if not user_signed_in?
            flash[:alert] = "アカウント作成またはログインが必要です"
            redirect_to new_user_registration_url
        end
    end

    protected
    # def configure_permitted_parameters
    #     # 追加したカラムの許可
    #     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #     devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    # end
end
