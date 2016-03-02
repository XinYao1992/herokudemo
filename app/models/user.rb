require 'digest/sha2'

class User < ActiveRecord::Base
  has_many:locations

  validates :name, :pressence => true, :uniqueness => true

  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  private

  def password_must_be_present
    errors.add(:password, "Missing password") unless password.present?
  end

  def User.encrpyt_password(password, user_id)
    Digest::SHA2.hexdigest(password + "wibble" + user_id)
  end

  def generate_user_id
    self.user_id = self.object_id.to_s + rand.to_s
  end

  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_user_id
      self.password = self.class.encrpyt_password(password, user_id)
    end
  end

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.password == encrpyt_password(password, user.user_id)
        user
      end
    end
  end

end
