class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :must_not_destroy_admin
  before_update :must_not_update_admin

  validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 100 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
  validates :password, length: { minimum: 4 }

  has_many :tasks, dependent: :destroy

  enum admin: { true: true, false: false }

  private

  def must_not_destroy_admin
    throw(:abort) if User.where(admin: true).count == 1  && self.admin?
  end

  def must_not_update_admin
    throw(:abort) if User.where(admin: true).count == 1  && self.admin_change == ["true", "false"]
  end
end
