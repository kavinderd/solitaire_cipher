module Encrypter

  def encrypt(string)
  	start_deck
  	string = string.upcase
  	group = format_string(string)
  	keystream = keystream(group.join.length)
  	number_string = string_to_number_array(group)
  	number_keystream = []
  	keystream.each do |char|
  	  number_keystream << (char.ord - 64)
  	end
  	number_string = merge_string_keystream_numbers(number_string, number_keystream)
  	build_encryption(number_string)
  end

  def decrypt(string)

  end

  private

  def format_string(string)
    string = string.upcase.gsub(/[^0-9A-Za-z]/, '').scan(/.{1,5}/m)
    if string.last.length < 5
      (5 - string.length).times do 
      	string.last << 'X'
      end
    end
    string
  end

  def string_to_number_array(array)
  	result = []
  	array.each do |string_group|
  	  string_group.each_char do |char|
  	  	result << (char.ord - 64)
  	  end
  	end
  	result
  end

  def merge_string_keystream_numbers(number_string, number_keystream)
  	number_string.each_with_index do |number,i| 
  	  keystream_int = number_keystream[i]
  	  result = number + keystream_int
  	  result -= 26 if result > 26
  	  number_string[i]  = result
  	end
  	number_string
  end

  def build_encryption(array)
  	encrypted_string = []
  	array.each do |number|
  	  encrypted_string << (number + 64).chr
  	end
  	encrypted_string.join.scan(/.{1,5}/m).join(" ")
  end

end