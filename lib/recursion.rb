def palindrome?(word)
	return true if word.length <= 1
	return false if word.slice!(0) != word.slice!((word.length) -1)
	palindrome?(word)
end

p palindrome?("maya")
p palindrome?("racecar")
p palindrome?("afgfgdfgfda")