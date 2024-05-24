def substrings(word, dictionary)
  dictionary.each_with_object(Hash.new(0)) do |dictionary_word, hash|
    hash[dictionary_word] += word.downcase.scan(dictionary_word).size if word.downcase.include?(dictionary_word)
  end
end

# def substrings(word, dictionary)
#   dictionary.reduce({}) do |hash, dictionary_word|
#     if word.include?(dictionary_word)
#       if hash[dictionary_word] == nil
#         hash[dictionary_word] = 1
#       else
#         hash[dictionary_word]+=1
#       end
#     end
#     hash
#   end
# end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
