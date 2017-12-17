class Spanglish::DailyWord 

  def initialize
  end

  def get
    trans = translation.get

    trans.body
  end

  private

  def translation
    #maybe we should return more than one english word incase ... 
    @translation ||= Faraday.new(url: spanish_translation_uri(english_word), 
                                 headers: headers)
  end

  def english_word
    @word ||= 
      begin
        response = connection.get
        json = JSON.parse response.body
        json["results"].first["word"]
      end
  end

  def connection
    Faraday.new(url: english_word_uri, 
                headers: headers)
  end

  def headers
    { 'Accept' => 'application/json',
      'app_id' => ENV['oxford_dictionary_app_id'], 
      'app_key' => ENV['oxford_dictionary_app_key'] }
  end

  def spanish_translation_uri(english_word)
    "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{english_word}/translations=es"
  end

  def english_word_uri
    "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/en/lexicalCategory%3D#{filters_basic}?limit=1&offset=#{offset}"
  end

  def query
    "wordlist/es/lexicalCategory%3D#{filters_basic}?limit=1&offset=#{offset}"
  end

  def offset
    #the offset has to be mapped to the filter_basic :-/ 
    rand(0..158518)
  end

  def filters_basic
    %w(adjective adverb interjection noun other preposition pronoun verb).sample
  end

end 
