class BitVector
  def initialize(*values)
    @value = mask(values)
  end

  def empty?
    @value == 0
  end

  def include?(*values)
    mask = mask(values)

    (@value & mask) == mask
  end

  def +(other)
    create(@value | mask([other]))
  end

  def -(other)
    create(@value ^ mask([other]))
  end

  def to_i
    @value
  end

  def to_s
    @value.to_s(2)
  end

  def inspect
    "#<BitVector:#{to_s}>"
  end

  def ==(other)
    self.eql?(other)
  end

  def eql?(other)
    other.is_a?(BitVector) &&
      other.value == @value
  end

  def hash
    @value
  end

  protected

  def value
    @value
  end

  private

  def mask(values)
    values.inject(0) { |acc,v| acc ^ (1 << v) }
  end

  def create(value)
    vector = BitVector.new
    vector.instance_variable_set(:@value, value)

    vector
  end

  NONE = BitVector.new
end
