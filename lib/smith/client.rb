module Smith
  class Client
    
    attr_accessor :client_id, :base_url, :client_secret, :authorize_path, :token_path, :device_path

    DEFAULTS_PATHS = {
      :authorize_path     => '/oauth2/authorize',
      :token_path         => '/oauth2/token',
      :device_path        => '/oauth2/device/code',
    }
    
    
    def initialize(host, client_id, client_secret, options={})
      @base_url           = host
      @client_id          = client_id
      @client_secret      = client_secret
      puts options[:token_path]
      # @connection_options = options.fetch(:connection_options, {})
      # @connection_client  = options.fetch(:connection_client, OAuth2::HttpConnection)
      DEFAULTS_PATHS.keys.each do |key|
        instance_variable_set(:"@#{key}", options.fetch(key, DEFAULTS_PATHS[key]))
      end
    end
    
    def authorization_code
      Smith::Flow::AuthorizationCode.new(self)
    end
    
    def implicit
      Smith::Flow::Implicit.new(self)
    end
    
    def password
      Smith::Flow::Password.new(self)
    end
    
    def to_s
      out=[]
      out<<"host:#{@base_url}"
      out<<"client_id: #{@client_id}"
      out<<"client_secret: #{@client_secret}"
      out<<"authorize_path: #{@authorize_path}"
      out<<"token_path: #{@token_path}"
      out<<"device_path: #{@device_path}"
      out.join("\n")
    end
  end
end