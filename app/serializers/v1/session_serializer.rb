module V1
  class SessionSerializer < ActiveModel::Serializer

    attributes :email, :access_token, :uuid, :token_type, :user_id

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end

  end
end
