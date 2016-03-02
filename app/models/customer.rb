require 'digest/sha2'

class Customer < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  validate :password_must_be_present
  after_destroy :ensure_an_admin_remains

  def Customer.authenticate(name, password)
    if customer = find_by_name(name)
      if customer.hashed_password == encrypt_password(password, customer.salt)
        customer
      end
    end
  end

  def Customer.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password +"wibble"+ salt)
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private

  def password_must_be_present
    errors.add(:password, "Missing password") unless self.hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def ensure_an_admin_remains
    if Customer.count.zero?
      raise "Can't delete last user"
    end
  end

end
