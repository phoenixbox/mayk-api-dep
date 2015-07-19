module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/users
    # Creates an user
    def create
      @user = User.from_omniauth(user_params)

      if @user.save
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:token, {:account => github_account_params}, :provider)
    end

    def github_account_params
      [:id, :username, :displayName, :email, {:raw => github_raw_params} ]
    end

    def github_raw_params
      [
        :login,
        :id,
        :avatar_url,
        :gravatar_id,
        :url,
        :html_url,
        :followers_url,
        :following_url,
        :gists_url,
        :starred_url,
        :subscriptions_url,
        :organizations_url,
        :repos_url,
        :events_url,
        :received_events_url,
        :type,
        :site_admin,
        :name,
        :company,
        :blog,
        :location,
        :email,
        :hireable,
        :bio,
        :public_repos,
        :public_gists,
        :followers,
        :following,
        :created_at,
        :updated_at,
        :private_gists,
        :total_private_repos,
        :owned_private_repos,
        :disk_usage,
        :collaborators
      ]
    end
  end
end

# { provider: 'custom',
#   token: '',
#   refreshToken: undefined,
#   expiresIn: undefined,
#   query: {},
#   profile:
#    { id: 2892213,
#      username: 'phoenixbox',
#      displayName: 'Shane Rogers',
#      email: 'srogers@quickleft.com',
#      raw:
#       { login: 'phoenixbox',
#         id: 2892213,
#         avatar_url: 'https://avatars.githubusercontent.com/u/2892213?v=3',
#         gravatar_id: '',
#         url: 'https://api.github.com/users/phoenixbox',
#         html_url: 'https://github.com/phoenixbox',
#         followers_url: 'https://api.github.com/users/phoenixbox/followers',
#         following_url: 'https://api.github.com/users/phoenixbox/following{/other_user}',
#         gists_url: 'https://api.github.com/users/phoenixbox/gists{/gist_id}',
#         starred_url: 'https://api.github.com/users/phoenixbox/starred{/owner}{/repo}',
#         subscriptions_url: 'https://api.github.com/users/phoenixbox/subscriptions',
#         organizations_url: 'https://api.github.com/users/phoenixbox/orgs',
#         repos_url: 'https://api.github.com/users/phoenixbox/repos',
#         events_url: 'https://api.github.com/users/phoenixbox/events{/privacy}',
#         received_events_url: 'https://api.github.com/users/phoenixbox/received_events',
#         type: 'User',
#         site_admin: false,
#         name: 'Shane Rogers',
#         company: 'Quick Left',
#         blog: '',
#         location: '',
#         email: 'srogers@quickleft.com',
#         hireable: false,
#         bio: null,
#         public_repos: 102,
#         public_gists: 7,
#         followers: 8,
#         following: 2,
#         created_at: '2012-11-26T13:13:03Z',
#         updated_at: '2015-07-18T20:17:26Z',
#         private_gists: 6,
#         total_private_repos: 5,
#         owned_private_repos: 5,
#         disk_usage: 601652,
#         collaborators: 0,
#         plan: [Object] } } }
