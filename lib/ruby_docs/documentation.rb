require 'json'
require 'net/http'
require 'uri'

# TODO: test
module RubyDocs
  class Documentation
    API_URL = "http://api.rubydocs.com/search"

    class << self
      def search(question, project = nil, version = nil)
        response = Net::HTTP.get_response api_uri(question, project, version)
        response_hash = JSON.parse(response.body)
        response_hash['content']
      end

      def api_uri(question, project, version)
        api_url = "#{API_URL}?q=#{question}"
        api_url << "&project=#{project}" unless project.nil? || project.empty?
        api_url << "&version=#{version}" unless version.nil? || version.empty?
        URI.parse api_url
      end
    end
  end
end
