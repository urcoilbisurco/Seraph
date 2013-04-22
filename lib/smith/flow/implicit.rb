module Smith
  module Flow
    # Authorization Code Grant
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1
    class Implicit < Base
      def initialize(client)
        @client=client
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
        puts options["redirect_uri"]
        params={
          "grant_type"=>"token",
          "client_id"=>@client.client_id,
          "redirect_uri"=>options["redirect_uri"]
        }
        super(params)
      end
      
      
    end
  end
end