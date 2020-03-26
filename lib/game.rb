class Words
  def initialize
    @words_group = {}
  end

  def add(word)
    @words_group[word] = true
  end

  def check(word)
    @words_group[word] == true
  end
end
