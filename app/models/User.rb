class User
  PROPERTIES = [:id, :name, :email]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(attributes = {})
    attributes.each { |key, value|
      self.send("#{key}=", value) if PROPERTIES.member? key
    }
  end

  def initWithCoder(decoder)
    self.init
    PROPERTIES.each { |prop|
      value = decoder.decodeObjectForKey(prop.to_s)
      self.send((prop.to_s + "=").to_s, value) if value
    }
    self
  end

  def encodeWithCoder(encoder)
    PROPERTIES.each { |prop|
      encoder.encodeObject(self.send(prop), forKey: prop.to_s)
    }
  end
end

