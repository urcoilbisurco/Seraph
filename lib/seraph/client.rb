require 'json'
module Seraph
  class Client
    
    attr_accessor :client_id, :access_token, :base_url, :client_secret, :authorize_path, :token_path, :device_path

    DEFAULTS_PATHS = {
      :authorize_path     => '/oauth2/authorize',
      :token_path         => '/oauth2/token',
      :device_path        => '/oauth2/device/code',
    }
    
    
    def initialize(host, client_id, client_secret, options={})
      @base_url           = host
      @client_id          = client_id
      @client_secret      = client_secret
      if(options[:access_token])
        @access_token=Seraph::Token.new(self, options[:access_token])
      end
      DEFAULTS_PATHS.keys.each do |key|
        instance_variable_set(:"@#{key}", options.fetch(key, DEFAULTS_PATHS[key]))
      end
    end
    
    def authorization_code
      Seraph::Flow::AuthorizationCode.new(self)
    end
    
    def implicit
      Seraph::Flow::Implicit.new(self)
    end
    
    def password
      Seraph::Flow::Password.new(self)
    end
    
    def access_token=(token_body)
      @access_token=Seraph::Token.new(self,token_body)
    end
    
    def get(path, params={})
      call("get", path, params)
    end
    
    def post(path, params={})
      call("post", path, params)
    end
    
    def put(path, params={})
      call("put", path, params)
    end
    
    def delete(path, params={})
      call("delete", path, params)
    end
    
    def call(method, path, params={})
      token=@access_token.get_token
      connection=Seraph::Connection.new(URI(@base_url+path))
      params.merge!("access_token"=>token)
      res=connection.call(method, path, params)
      JSON.parse(res.body)
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