class StatesController < ApplicationController
    before_action :authenticate!, only: [:create]
    def show
        flash[:alert] = "投稿にはユーザー登録が必要です。" unless user_signed_in?
        # render 用
        @state = State.new # to avoid error in view

        @topic = Topic.find(params[:topic_id]) # to show topic info
        current_state = State.find(params[:id])
        @ancestor_states = current_state.ancestors
        @for_states = current_state.get_for_child_states
        @against_states = current_state.get_against_child_states

		# 閲覧数更新
		current_state.update(view: current_state.view+1)
    end
    def create
		@topic = Topic.find(params[:topic_id]) # to show topic info
        current_state = State.find(params[:id])
        @ancestor_states = current_state.ancestors
        @for_states = current_state.get_for_child_states
        @against_states = current_state.get_against_child_states

        @state = State.new(state_params)
		@state.owner = current_user
		@state.topic = @topic

		# 主張を投稿したユーザーはトピックに参加したことになる
		participation = Participation.new(
			user_id: current_user.id,
			topic_id: @topic.id
		)
		# すでに参加している場合は追加しない
		participation.save! unless Participation.exists?(user_id: current_user.id, topic_id: @topic.id)

        if @state.save && @state.create_state_relation(current_state)
            flash[:notice] = "主張を追加しました"
            redirect_to("/topics/#{@topic.hashid}/states/#{current_state.hashid}")
        else
            flash.now[:alert] = "投稿に失敗しました。メッセージを確認してください"
            return render("/states/show")
        end
    end

	private
	def state_params
		params.require(:state).permit(:content, :position)
	end
end
