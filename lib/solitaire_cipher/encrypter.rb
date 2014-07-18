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

=begin
def encrypt(message)
	# Step 1
	message = message.upcase.tr("^A-Z", "")
	i = 5
	while i < message.size
		message[i, 0] = " "
		i += 6
	end
	message += "X" while message.rindex(" ") != message.size - 6
	
	# Step 2
	key_stream = generate(message.count("^ "))
	
	# Step 3
	values = message.split("").map { |letter| letter[0] - ?A + 1 }

	# Step 4
	key_values = key_stream.split("").map { |letter| letter[0] - ?A + 1 }
	
	# Step 5
	values.each_with_index do |value, index|
		next if value < 0
		values[index] = value + key_values[index]
		values[index] -= 26 if values[index] > 26
	end
	
	# Step 6
	message = (values.map { |number| (number - 1 + ?A).chr }).join("")
	
	return message
end

def decrypt(message)
	# Step 1
	key_stream = generate(message.size)
	
	# Step 2
	values = message.split("").map { |letter| letter[0] - ?A + 1 }

	# Step 3
	key_values = key_stream.split("").map { |letter| letter[0] - ?A + 1 }
	
	# Step 4
	values.each_with_index do |value, index|
		next if value < 0
		if value <= key_values[index]
			values[index] = value + 26 - key_values[index]
		else
			values[index] = value - key_values[index]
		end
	end
	
	# Step 5
	message = (values.map { |number| (number - 1 + ?A).chr }).join("")
	
	return message
end
	

	
=end