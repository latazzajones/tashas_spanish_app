class Spanglish::DailyWord 

  def initialize
  end

  def get
    connection = Faraday.new(url: uri, headers: headers)

    response = connection.get
    binding.pry

    response.body
  end

  private

  def headers
    { 'app_id' => ENV['oxford_dictionary_app_id'], 
      'app_key' => ENV['oxford_dictionary_app_key'] }
  end

  def uri
    #TODO concatinate!
    "https://od-api.oxfordictionaries.com/api/v1/wordlist/en/lexicalCategory%3Dnoun?limit=1&offset=300"
  end

  def query
    "wordlist/es/lexicalCategory%3D#{filters_basic}?limit=1&offset=#{offset}"
  end

  def offset
    rand(0..3)
  end

  def filters_basic
    %w(adjective adverb conjunction idiomatic interjection noun numeral other preposition pronoun suffix verb).sample
  end

end 
