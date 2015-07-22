module V1
  module Sessions
    class CreateSerializer < ActiveModel::Serializer
      attributes  :access_token,
                  :uuid,
                  :token_type,
                  :user_id,
                  :github_username,
                  :github_email,
                  :github_display_name,
                  :github_oauth_token

      def user_id
        object.id
      end

      def token_type
        'Bearer'
      end

      def github_username
        github_account.username
      end

      def github_oauth_token
        github_account.token
      end

      def github_email
        github_account.email
      end

      def github_display_name
        github_account.display_name
      end

      def github_account
        object.authentications.find_by_provider('github')
      end
    end
  end
end
