=begin
convert and decrypt list of names
input: a list of names which should be treated as a string 
break apart into each individual names
output: a list with decrypted names
Nqn Ybirynpr -- > Ada Lovelace
approach:
split the string into individual names in an array
iterate through each name and map them into a new array with new names
iterate through each letter in the name and skip the space
downcase the letter
if the letter is >13, use ord to - 13 to find matching letter
if letter ord is <= 13, use ord to + 13 to find the matching letter
  upcase if original letter is upcased
combine the new array into a string with trailing space as before
=end
ENCRYPTED_PIONEERS = [
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
].freeze

def decipher_character(char)
  position = char.downcase.ord 
  new_pos = position <= 109 ? position + 13 : position - 13
  char.upcase == char ? new_pos.chr.upcase : new_pos.chr
end

def decipher(name)
  name.chars.map do |char|
    if char =~ /['A-Za-z']/
      decipher_character(char)
    else
      char
    end
  end.join
end


ENCRYPTED_PIONEERS.each do |encrypted_name|
  puts decipher(encrypted_name)
end