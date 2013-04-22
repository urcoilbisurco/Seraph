require 'uri'

module Smith
  module Flow
    # Authorization Code Grant
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1
    # x=a.authorization_code.auth_uri({"redirect_uri"=>"http://google.com/callback"})
    class AuthorizationCode < Base

      
      def auth_uri(options={})
        url=URI.join(@client.base_url,@client.authorize_path)
        puts options[:redirect_uri]
        params=URI.encode_www_form("response_type" => "code",
                            #"scope" => options.scope,
                            "client_id"=>@client.client_id,
                            "redirect_uri"=>options[:redirect_uri])
        url.to_s+"/?"+params
      end
      
      # options: 
      #   redirect_uri
      #   code
      # a.authorization_code.get_token({"code"=>"abc" ,"redirect_uri"=>"http://google.com/callback"})
      def get_token(options={})
        puts options
        # grant_type : authorization_code
        # code: #code
        # redirect_uri: #redirect
        # client_id: #client_id
        puts options[:redirect_uri]
        params={
          "grant_type"=>"authorization_code",
          "client_id"=>@client.client_id,
          "client_secret"=>@client.client_secret,
          "redirect_uri"=>options[:redirect_uri],
          "code"=>options[:code]
        }
        super(params)
        
      end
      
      
    end
  end
end