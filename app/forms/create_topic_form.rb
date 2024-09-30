class CreateTopicForm
	# topic作成時に最初の主張の投稿と、参加テーブルへの追加も同時に行うためのモデル

    include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
    include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする
	include ActiveModel::Validations

	attribute :title, :string
    attribute :description, :string
	attribute :image, :string
	attribute :state_content, :string

	validates :title, presence: true, length: {minimum: 4, maximum: 40}
    validates :description, presence: true, length: {maximum: 500}
    validates :image, presence: true
	validates :state_content, presence: true, length: {maximum: 300}

    def save(current_user)
		return false unless valid?
		# image_valid
		# imgs_arr = [0,1,2,3]
		# return false unless imgs_arr.include?(image)

		topic = Topic.new(
			title: title,
			description: description,
			image: image+".jpg",
			owner_id: current_user.id
		)
		topic.save!

		participation = topic.participations.build(
			user_id: current_user.id
		)
		participation.save!

		state = topic.states.build(
			content: state_content,
			owner_id: current_user.id
		)
		state.save!

		state_relation = StateRelation.new(
			ancestor_id: state.id,
			descendant_id: state.id
		)
		state_relation.save!

		return topic
    end
end
