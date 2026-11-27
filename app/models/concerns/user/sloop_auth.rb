module User::SloopAuth
  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :confirmable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :trackable, :lockable, :omniauthable, omniauth_providers: [:google_oauth2]
    PASSWORD_COMPLEXITY = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).+\z/

    validate :password_complexity, if: -> { password.present? && provider.blank? }
  end

  def to_s
    return name if name.present?
    email.split("@")[0]
  end

  class_methods do
    def from_google(user_attributes)
      create_with(
        uid: user_attributes[:uid],
        provider: "google",
        name: user_attributes[:name],
        password: Devise.friendly_token[0, 20]
      ).find_or_create_by!(email: user_attributes[:email])
    end
  end

  def password_complexity
    errors.add(:password, :too_weak) unless password.match?(PASSWORD_COMPLEXITY)
  end
end
