require 'uri'
require 'net/http'
require 'net/https'

module Smith
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
    
    
    
    
    def initialize(host)
      @url=url
      @http = Net::HTTP.new(@url.host, @url.port)
      if (url.scheme=="https")
        @http.use_ssl = true 
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end  
    end
    
    def do_post(params)
      request = Net::HTTP::Post.new(@url.path)
      request.set_form_data(params)
      res = @http.request(request)
      
      parse_response(res)
    end
    
    def do_get(params)
      uri_params=URI.encode_www_form(params)
      request = Net::HTTP::Get.new(@url.path+"/?"+uri_params)
      res = @http.request(request)
      
      parse_response(res)
    end
    
    def parse_response(res)
      status=res.code.to_i
      case status
      when 200..299
        response
      when 301, 302, 303, 307
        raise "Expected redirect to #{res.header['Location']}"
      else
        raise "Unhandled status code value of #{response.code}"
      end
      response
    rescue *NET_HTTP_EXCEPTIONS
      raise "Error::ConnectionFailed, $!"
    end
    
  end
end