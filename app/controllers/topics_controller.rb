class TopicsController < ApplicationController
    before_action :authenticate!, only: [:new, :create]

    def index
        @topics = Topic.all.order(created_at: :desc)
    end

    def new
		@create_topic_form = CreateTopicForm.new
    end

    def create
		@create_topic_form = CreateTopicForm.new(create_topic_params)
		if topic = @create_topic_form.save(current_user)
			flash[:notice] = "トピックを作成しました"
			redirect_to topic_path(topic.hashid)
		else
            flash.now[:alert] = "トピックの作成に失敗しました"
            render("/topics/new")
		end
    end

	def show
		# top stateに転送する
		topic = Topic.find(params[:id])
		topic.update(view: topic.view+1)
		redirect_to topic_state_path(topic.hashid, topic.top_state.hashid)
	end


    private
    def create_topic_params
        params.require(:create_topic_form).permit(
            :title,
            :description,
            :image,
            :state_content
        )
    end
end
