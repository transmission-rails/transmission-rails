module Application
  # This module contains various helper definitions for the gravatar
  # service it is mostly called when a model which contains a gravatar link is saved.
  module Gravatar
    # Create a gravatar link based on the users email This is triggered before
    # the model is saved sets the users gravatar attribute
    #
    # @return [String], the url for gravatar
    def create_url(subject, options = {d: 'identicon', s: 200})
      "http://www.gravatar.com/avatar/#{digest subject}?d=#{options[:d]}&s=#{options[:s]}"
    end

    private

    # Create an MD5 hash of the subject passed in
    # This will be used by gravatar
    #
    # @return [String], the resulting digest
    def digest(subject)
      Digest::MD5.hexdigest subject.downcase
    end
  end
end