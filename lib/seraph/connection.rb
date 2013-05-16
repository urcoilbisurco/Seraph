require 'uri'
require 'net/http'
require 'net/https'

module Seraph
  class Connection
    
    NET_HTTP_EXCEPTIONS = [
       EOFError,
       Errno::ECONNABORTED,
       Errno::ECONNREFUSED,
       Errno::ECONNRESET,
       Errno::EINVAL,
       Net::HTTPBadResponse,
       Net::HTTPHeaderSyntaxError,
       Net::ProtocolError,
       SocketError,
     ]
    
    
    
    
    def initialize(url)
      @url=url
      @http = Net::HTTP.new(@url.host, @url.port)
      if (url.scheme=="https")
        @http.use_ssl = true 
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end  
    end
    
    def call(method, params)
      token=params.delete "access_token"
      headers =  token ? { "Authorization" => "Bearer #{token}" } : {}
      case method
      when "get"
        uri_params=URI.encode_www_form(params)
        p= uri_params ?  ("?"+uri_params) : ""
        request = Net::HTTP::Get.new(@url.path+p, headers)
      when "post"
        request = Net::HTTP::Post.new(@url.path, headers)
        request.set_form_data(params)
      when "put"
        request = Net::HTTP::Put.new(@url.path, headers)
        request.set_form_data(params)
      when "delete"
        request = Net::HTTP::DELETE.new(@url.path, headers)
      end
      res = @http.request(request)
      parse_response(res)
    end
    
    def parse_response(res)
      status=res.code.to_i
      case status
      when 200..299
        res
      when 301, 302, 303, 307
        raise "Expected redirect to #{res.header['Location']}"
      else
        raise "Unhandled status code value of #{res.code}"
      end
      res
    rescue *NET_HTTP_EXCEPTIONS
      raise "Error::ConnectionFailed, $!"
    end
    
  end
end