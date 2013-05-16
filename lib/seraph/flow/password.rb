module Seraph
  module Flow
    # Authorization Code Grant
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1
    # x=a.authorization_code.auth_uri({"redirect_uri"=>"http://google.com/callback"})
    class Password < Base

      
      # options:
      #   username
      #   password
      def get_token(options={})
        # grant_type : password
        # username: username
        # password: password
        params={
          "grant_type"=>"password",
          "username"=>options[:username],
          "password"=>options[:password],
          "client_id"=>@client.client_id,
          "client_secret"=>@client.client_secret
        }
        super(params)
        
      end
    end
  end
end