class Nlp
  class << self
    # TODO: use real NLP, not this silly chunk of code
    def closest_sentence(string, sentences)
      string_tokens = split_into_tokens(string)
      string_tokens_size = string_tokens.size
      closest_sentence = nil
      closest_sentence_size = 0
      sentences.each do |sentence|
        sentence_tokens = split_into_tokens(sentence)
        common_tokens = string_tokens & sentence_tokens
        bigger_sentence_size = [sentence_tokens.size, string_tokens_size].max
        if bigger_sentence_size - common_tokens.size == 1 && bigger_sentence_size > closest_sentence_size
          closest_sentence = sentence
          closest_sentence_size = bigger_sentence_size
        end
      end
      closest_sentence
    end

    def split_into_tokens(string)
      string.gsub('?', '').downcase.split
    end
  end
end
