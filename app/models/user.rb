class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence:true
  validates :password, length:{minimum: 6, allow_nil: true}
  attr_reader :password

  before_validation :ensure_session_token

  has_many :subs

  has_many :posts

  has_many :comments 

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

end
