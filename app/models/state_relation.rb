class StateRelation < ApplicationRecord
    belongs_to :ancestor, class_name: 'State', foreign_key: 'ancestor_id'
    belongs_to :descendant, class_name: 'State', foreign_key: 'descendant_id'
end
