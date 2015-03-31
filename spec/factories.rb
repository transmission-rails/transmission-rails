FactoryGirl.define do
  factory :user do
    name          'name'
    username      'username'
    password      'password'
    email         'email@email.com'
  end

  factory :connection do
    name          'name'
    host          'localhost'
    port          9091
    path          '/transmission/rpc'
    ssl           true
  end
end