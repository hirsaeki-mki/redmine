module ActionController
  module DataStreaming
    def send_file_headers_with_utf8!(options)
      send_file_headers_without_utf8!(options)
      match = /(.+); filename="(.+)"/.match(headers['Content-Disposition'])
      encoded = URI.encode_www_form_component(match[2])
      headers['Content-Disposition'] = "#{match[1]}; filename*=UTF-8''#{encoded}" unless encoded == match[2]
    end
    alias_method_chain :send_file_headers!, :utf8
  end
end
