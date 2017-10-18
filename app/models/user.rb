class User < ApplicationRecord
  before_save { self.email.downcase! } # a call back method that gets run every time before a user is saved to the DB
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 255 },
                                    format:     { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  has_secure_password # adds: - The ability to save a securely hashed password_digest attribute to the database
                      #       - A pair of virtual attributes(password and password_confirmation), including presence validations upon object creation and a validation requiring that they match
                      #       - An authenticate method that returns the user when the password is correct (and false otherwise)
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
