class User < ActiveRecord::Base
  include BCrypt

  has_many :connections

  validates :name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  class << self
    def authenticate!(username, password)
      user = User.find_by_username(username)
      user && user.password == password ? user : nil
    end
  end

end