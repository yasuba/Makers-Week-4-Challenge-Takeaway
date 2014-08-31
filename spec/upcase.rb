def my_upcase(val)
  val.split("").map {|x|x.ord}.map! {|x| (97..122).include?(x) ? (x - 32).chr : x.chr }.join 
end
p my_upcase('Hello!')  # => "HELLO!"