class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :trackable and :omniauthable
    devise  :database_authenticatable, :registerable,
            :rememberable, :validatable,
            :timeoutable
			#:confirmable,:recoverable,

    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 16 }

    # ユーザーはトピックの作成者(オーナー)としてトピックを多数所有, ユーザー退会後もトピックは残る
    has_many :owning_topics, class_name: 'Topic', foreign_key: 'owner_id'
    # ユーザーは主張の作成者(オーナー)として主張を多数所有, ユーザー退会後も主張は残る
    has_many :owning_states, class_name: 'State', foreign_key: 'owner_id'
    # ユーザーは多数のトピックに参加, ユーザーが退会したら参加情報のみを消す
    has_many :participations, dependent: :destroy
    has_many :participating_topics, through: :participations, source: :topic

	def email_required?
    	false
  	end
end
