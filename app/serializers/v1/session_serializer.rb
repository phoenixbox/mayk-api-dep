module V1
  class SessionSerializer < ActiveModel::Serializer

    attributes :email, :access_token, :uuid, :token_type, :user_id, :github_token

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end

    def github_token
      object.authentications.find_by_provider('github').token
    end
  end
end
