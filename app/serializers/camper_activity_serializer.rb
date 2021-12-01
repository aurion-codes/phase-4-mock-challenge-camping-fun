class CamperActivitySerializer < ActiveModel::Serializer
  attributes :name

  has_many :activities, serializer: CamperActivitySerializer
end
