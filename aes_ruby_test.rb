require 'base64'
require 'openssl'

def aes_encrypt(key, iv, data)
	cipher = OpenSSL::Cipher.new('aes-256-cbc')
	cipher.encrypt

	cipher.key = key
	cipher.iv = iv

	encrypted = cipher.update(data) + cipher.final

	return encrypted
end

def aes_decrypt(key, iv, encrypted)
	decipher = OpenSSL::Cipher.new('aes-256-cbc')
	decipher.decrypt
	decipher.padding = 1
	decipher.key = key
	decipher.iv = iv

# ...

	decrypted = ""
	decrypted << decipher.update(encrypted)
	decrypted << decipher.final

	return decrypted
end

# key = "put_your_key_here"
# iv = "put_your_iv_here"
# data = "put_your_data_string_here"

key = '57119C07F45756AF6E81E662BE2CCE62'
iv = Base64::decode64 'TYzSTNrjM3a1xhhmLDtVIA=='
data = "Hello World"

print("iv: " + Base64::encode64(iv))

encrypted = aes_encrypt(key, iv, data)
# encrypted = Base64::decode64("UuTMl8k/8eK5NcsX3abWYw==")

print("encrypted: " + Base64::encode64(encrypted))

decrypted = aes_decrypt(key, iv, encrypted)
print("decrypted: " + decrypted + "\n")
