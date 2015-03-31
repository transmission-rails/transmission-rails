require 'transmission'

class Connection < ActiveRecord::Base

  belongs_to :user

  validates :name, :host, :port, :path, presence: true

  attr_encrypted :username, :password, key: 'fc91896c3623a38b8c47782d15a43e828a3de6695de218525ced9014a216d6bdb0077392704873999505c1bedddea870f7cb1af7c4bff579ad609ad83f128aa6'

  def rpc
    Transmission::RPC.new rpc_options
  end

  private

  def rpc_options
    options = { host: host, port: port, path: path, ssl: ssl, session_id: session_id }
    options[:credentials] = { username: username, password: password } if credentials
    options
  end

end