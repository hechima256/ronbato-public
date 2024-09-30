class State < ApplicationRecord
    validates :content, presence: true, length: {maximum: 300}
    validates :topic_id, presence: true, numericality: true
    validates :position, presence: true, inclusion: {in: [-1, 0, 1]}, numericality: true
    validates :view, presence: true, numericality: true

	# state_id をハッシュ化
	include Hashid::Rails
    # 主張はトピックに属する
    belongs_to :topic
    # 主張には作成者(オーナー)がいる
    belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
    # 主張には多数の子孫が存在, 主張が削除されたときは関係と子孫すべてを削除する
    # この主張.id=ancestor_idとなるものが主張の子孫に関するstate_relations
    has_many :descendant_state_relations, class_name: 'StateRelation', foreign_key: 'ancestor_id', dependent: :destroy
    has_many :descendants, through: :descendant_state_relations, source: :descendant, dependent: :destroy
    # 主張には多数の先祖が存在, 主張が削除されたときは関係のみを削除する
    # この主張.id=descendant_idとなるものが主張の先祖に関するstate_relations
    has_many :ancestor_state_relations, class_name: 'StateRelation', foreign_key: 'descendant_id', dependent: :destroy
    has_many :ancestors, through: :ancestor_state_relations, source: :ancestor



    # Class method


    # instance method
	def get_parent_state
		# generation == 1 means that there are parent-child relation
		state_relation = self.ancestor_state_relations.find_by(generation: 1)
		return State.where(id: state_relation.ancestor_id)
	end

    # return child states (out: object array sorted? by ascending[time])
    def get_child_states
		# generation == 1 means that there are parent-child relation
		state_relations = self.descendant_state_relations.where(generation: 1)
		ids = Array.new
		state_relations.each do |state_relation|
			ids.append(state_relation.descendant_id)
		end
		return State.where(id: ids)
    end

	def get_for_child_states
		# position == 1 means that it is agree state
		return self.get_child_states.where(position: 1)
	end

	def get_against_child_states
		# position == -1 means that it is agree state
		return self.get_child_states.where(position: -1)
	end

	def create_state_relation(parent)
		# 新主張の先祖 = 元の主張の先祖 + 自分自身
		# generationはプラス1
		anc_state_relations = parent.ancestor_state_relations
		anc_state_relations.each do |relation|
			state_relation = StateRelation.new(ancestor_id: relation.ancestor_id, descendant_id: self.id, generation: relation.generation+1)
			return 0 unless state_relation.save
		end
		# 自分自身の関係
		state_relation = StateRelation.new(
			ancestor_id: self.id,
			descendant_id: self.id
		)
		return state_relation.save
	end

    # return html color class of state (out: string)
    def state_class
        if self.position == 1
            return "for_state"
        elsif self.position == -1
            return "against_state"
        else
            return "first_state"
        end
    end

	# 配下に複数の主張があればhtmlクラスstate_multi, なければ空文字列を返す
	def multi
		if self.descendants.count > 1
			return "state_multi"
		else
			return ""
		end
	end

end
