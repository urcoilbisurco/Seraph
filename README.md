Seraph
======

Seraph is a simple Ruby wrapper for OAuth 2.0.


## Installation
    gem install seraph


## Usage Examples
    require 'seraph'
    client = Seraph::Client.new('https://example.org', 'client_id', 'client_secret')
    client.authorization_code.auth_uri(:redirect_uri => 'http://localhost:8080/oauth2/callback', :scope=>'read write')
    # => "https://example.org/oauth/authorize?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

    token = client.authorization_code.get_token(:code=>'code', :redirect_uri => 'http://localhost:8080/oauth2/callback')
    response = client.get('/api/resource', :params => { 'query_foo' => 'bar' })