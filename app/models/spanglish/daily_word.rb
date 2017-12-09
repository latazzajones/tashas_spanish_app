class Spanglish::DailyWord 

  def self.get
    self.new.get
  end

  def initialize
  end

  def get
    response = https.request(request)
    response.body
  end

  private

  def request
    req = Net::HTTP::Get.new(uri.path)
    req['app_id'] = ENV['oxford_dictionary_app_id']
    req['app_key'] = ENV['oxford_dictionary_app_key']

    req
  end

  def https
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    http
  end

  def uri
    URI.parse "https://od-api.oxforddictionaries.com/api/v1/#{query}"
  end

  def query
    "wordlist/es/lexicalCategory%3D#{filters_basic}?limit=1&offset=#{offset}"
  end

  def offset
    rand(0...3000)
  end

  def filters_basic
    %w(adjective adverb conjunction idiomatic interjection noun numeral other preposition pronoun suffix verb).sample
  end

end 
