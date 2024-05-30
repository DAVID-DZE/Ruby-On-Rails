
class HashMap

  def initialize
    @keys = []
    @values = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % 100
    @keys[index] = key
    @values[index] = value
  end

  def get(key)
    index = hash(key) % 100
    @values[index]
  end

  def has(key)
    index = hash(key) % 100
    !@keys[index].nil?
  end

  def remove(key)
    index = hash(key) % 100
    deleted_value = @values[index]
    @keys[index] = nil
    @values[index] = nil
    deleted_value
  end

  def length
    @keys.count { |key| !key.nil? }
  end

  def clear
    @keys = []
    @values = []
  end

  def keys
    @keys.select { |key| !key.nil? }
  end

  def values
    @values.select { |value| !value.nil? }
  end

  def entries
    @keys.zip(@values).select { |key, value| !key.nil? }
  end

end

hash_map = HashMap.new
hash_map.set('hello', 'world')
p hash_map.get('hello') # => 'world'
p hash_map.get('goodbye') # => nil
p hash_map.has('hello') # => true
p hash_map.has('goodbye') # => false
p hash_map.length # => 100
p hash_map.keys # => ['hello']
p hash_map.values # => ['world']
p hash_map.entries # => [['hello', 'world']]
