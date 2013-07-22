require 'rack'
require 'httparty'
require 'json'

class HTMLGist
  def call(env)
    slug = env["PATH_INFO"].slice(1..-1)
    return if slug == "favicon.ico"
    response = HTTParty.get("https://api.github.com/gists/#{slug}")
    content  = JSON.parse(response.body)["files"].first.last["content"]
    [200, {"Content-Type" => "text/html"}, StringIO.new(content)]
  end
end

run HTMLGist.new()