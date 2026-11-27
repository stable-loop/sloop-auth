class Users::GoogleSignInsController < ApplicationController
  def create
    return render json: { error: "Google token is missing." }, status: :unprocessable_entity if params[:id_token].blank?

    payload = Google::Auth::IDTokens.verify_oidc(
      params[:id_token].to_s,
      aud: Cred[:google_oauth_client_id]
    )
    return render json: { error: "Google account is not verified." }, status: :unauthorized unless payload["email_verified"]

    user = User.from_google(google_attributes(payload))

    sign_in user, event: :authentication, remember: true
    render json: { success: true }
  rescue Google::Auth::IDTokens::KeySourceError,
         Google::Auth::IDTokens::VerificationError => error
    Rails.logger.warn "Google native sign-in failed: #{error.class}: #{error.message}"
    render json: { error: "Google authentication failed." }, status: :unauthorized
  end

  private

  def google_attributes(payload)
    {
      uid: payload["sub"] || payload[:sub],
      name: payload["name"] || payload[:name],
      email: payload["email"] || payload[:email]
    }
  end
end
