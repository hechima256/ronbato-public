class Topic < ApplicationRecord
    validates :title, presence: true, length: {minimum: 4, maximum: 20}
    validates :description, presence: true, length: {maximum: 500}
    validates :image, presence: true
    validates :view, presence: true, numericality: true

	# topic_id をハッシュ化
	include Hashid::Rails
    # トピックには作成者(オーナー)がいる
    belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
    # 一つのトピックには多数のユーザーが参加, トピックが削除されたら参加者情報のみを消す
    has_many :participations, dependent: :destroy
    has_many :participants, through: :participations, source: :user
    # トピックには多数の主張が投稿される, トピックが削除されたら主張は消える
    has_many :states, dependent: :destroy

    # Class method
    # return current topic (out: object)
    def self.current_topic(topic_id)
        self.find(topic_id)
    end

	# instance method
	def top_state
		return self.states.find_by(position: 0)
	end
end
