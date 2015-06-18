# == Schema Information
#
# Table name: users
#
# t.string   "username",               default: "", null: false
# t.string   "email",                  default: "", null: false
# t.string   "encrypted_password",     default: "", null: false
# t.string   "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.integer  "sign_in_count",          default: 0,  null: false
# t.datetime "current_sign_in_at"
# t.datetime "last_sign_in_at"
# t.string   "current_sign_in_ip"
# t.string   "last_sign_in_ip"
# t.string   "name"
# t.boolean  "admin"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "avatar"
# t.string   "skype"
# t.string   "twitter"
# t.string   "facebook"
# t.string   "linkedin"
# t.string   "gravatar"
# t.datetime "last_seen"
#
class User < ActiveRecord::Base
  include Application::Gravatar
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :trackable,
         :validatable,
         :omniauthable,
         :confirmable

  #
  # Validations
  #
  validates_presence_of :username
  validates_presence_of :name
  validates_uniqueness_of :username

  #
  # Hooks
  #
  before_save { self.gravatar = create_url email }

  #
  # Class Methods
  #
  class << self
    # Looks up the users table in order to authenticate a potential user
    #
    # @param username[String], the username to authenticate with
    # @param password[String], the password to authenticate with
    # @param request[ActionDispatch::Request], the http request used to update tracking fields.
    #
    # @return [User, Boolean] a user instance if successful, false if unsuccessful
    def authenticate!(username, password, request)
      user = User.find_by_username username
      if user && user.valid_password?(password)
        user.update_tracked_fields! request
        user.save!
        user
      else
        false
      end
    end
  end
end