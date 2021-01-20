class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_otp

  private

  def generate_otp
    self.otp = rand(999_999)
  end
end
