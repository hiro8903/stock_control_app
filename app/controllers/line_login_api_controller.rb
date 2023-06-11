class LineLoginApiController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'securerandom'

  def login
    # CSRF対策用の固有な英数字の文字列
    # ログインセッションごとにWebアプリでランダムに生成する
    session[:state] = SecureRandom.urlsafe_base64
    
    # ユーザーに認証と認可を要求する
    # https://developers.line.biz/ja/docs/line-login/integrate-line-login/#making-an-authorization-request
    
    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    response_type = 'code'
    client_id = ENV['LINE_LOGIN_CHANNEL_ID'] 
    redirect_uri = CGI.escape("https://#{ENV['NGLOK_URL']}/line_login_api/callback")

    state = session[:state]
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限
    
    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
    
    redirect_to authorization_url, allow_other_host: true
  end

  def callback
    # CSRF対策のトークンが一致する場合のみ、ログイン処理を続ける
    if params[:state] == session[:state]
      get_line_user_profile(params[:code])
      user = User.find_or_initialize_by(name: @line_user_name)
      user[:line_user_id] = @line_user_id
      if user.save
        session[:user_id] = user.id
        flash[:success] = 'ログインしました。'
        redirect_to after_login_path
      elsif # 初回LINEログイン時は部署とパスワードが登録されていないので、仮登録してログインする
        user[:department_id] = 1
        user[:password_digest] = 1234
        user.save
        flash[:success] = "ユーザーを新規作成しました。部署とパスワード(1234)が仮登録されています。<br>
                            部署とパスワードを変更してください。"
        redirect_to edit_user_path(user)
      else
        flash[:danger] = 'ログイン失敗しました。'
        redirect_to root_path
      end

    else
      flash[:danger] = '不正なアクセスです。'
      redirect_to root_path
    end

  end

  private

  def get_line_user_profile(code)
    # ユーザーのIDトークンからプロフィール情報（ユーザー情報）を取得する
    # https://developers.line.biz/ja/docs/line-login/verify-id-token/

    line_user_id_token = get_line_user_id_token(code)

    if line_user_id_token.present?
      url = 'https://api.line.me/oauth2/v2.1/verify'
      options = {
        body: {
          id_token: line_user_id_token,
          client_id: ENV['LINE_LOGIN_CHANNEL_ID']
        }
      }

      response = Typhoeus::Request.post(url, options)

      if response.code == 200
        @line_user_id = JSON.parse(response.body)['sub']
        @line_user_name = JSON.parse(response.body)['name']
      else
        nil
      end
    
    else
      nil
    end
  end

  def get_line_user_id_token(code)
#     ユーザーのアクセストークン（IDトークン）を取得する
#     https://developers.line.biz/ja/reference/line-login/#issue-access-token

    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_uri = "https://#{ENV['NGLOK_URL']}/line_login_api/callback"

    options = {
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: redirect_uri,
        client_id: ENV['LINE_LOGIN_CHANNEL_ID'],
        client_secret: ENV['LINE_LOGIN_CHANNEL_SECRET']
      }
    }
    response = Typhoeus::Request.post(url, options)

    if response.code == 200
      JSON.parse(response.body)['id_token'] # ユーザー情報を含むJSONウェブトークン（JWT）
    else
      nil
    end
  end

end