module ControlHelper

def rndpass(length=8)
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password
end

end
