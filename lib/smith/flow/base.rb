require 'uri'
require 'json'


module Smith
  module Flow
    class Base

      def initialize(client)
        @client=client
      end
      
      def get_token(params)
        connection=Smith::Connection.new(URI.join(@client.base_url, @client.token_path))
        res=connection.do_post(params)
        
        puts "Response #{res.code} #{res.message}: #{res.body}"
        body=JSON.parse(res.body)
        puts body["access_token"]
        token=Smith::Token.new(body)
      end
    end
  end
  
end