module V1
  module User
    class CreateSerializer < ActiveModel::Serializer
      attributes :access_token, :uuid
    end
  end
end
