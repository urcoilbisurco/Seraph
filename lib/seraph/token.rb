module Seraph
  class Token
    
    #attr_reader   :host, :connection_options
    attr_accessor :access_token
    
    
    def initialize(client, options={})
      @client=client
      setup_refresh_token(options)
    end
    
    
    def setup_refresh_token(options={})
      puts options
      @access_token       = options["access_token"]
      @refresh_token      = options["refresh_token"]
      @expires_in         = options["expires_in"]
      if @expires_in
        @expires_at         = Time.new + @expires_in
      else
        @expires_at       = nil
      end
    end
    
    def get_token
      if(@refresh_token and !valid?)
          refresh!
      else
        @access_token
      end
    end
    
    # def to_s
    #   get_token
    # end
    
    def to_s
      out=[]
      out<<"access_token:#{@access_token}"
      out<<"refresh_token: #{@refresh_token}"
      out<<"expires_in: #{@expires_in}"
      out<<"expires_at: #{@expires_at}"
      out.join("\n")
    end
    
    
    
    private 
      def valid?
        Time.new < @expires_at
      end
    
      def refresh!
        #do the request to refresh the token and return the new token
        # grant_type : "refresh_token"
        # refresh_token : refresh_token
        params={
          "grant_type"=>"refresh_token",
          "refresh_token"=>@refresh_token
        }
        connection=Seraph::Connection.new(URI.join(@client.base_url, @client.token_path))
        res=connection.do_post(params)
      
        setup_refresh_token(res.body)
      
        puts "Response #{res.code} #{res.message}: #{res.body}"
        @access_token
      end
    
   
  end
end