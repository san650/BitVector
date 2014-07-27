require "minitest/autorun"

class TestBit < Minitest::Test
  READ    = 0
  WRITE   = 1
  EXECUTE = 2

  def test_empty
    vector = BitVector.new

    assert vector.empty?, "vector not empty"
  end

  def test_not_empty
    vector = BitVector.new(READ)

    refute vector.empty?, "vector empty"
  end

  def test_include
    vector = BitVector.new(READ, WRITE, EXECUTE)

    assert vector.include?(READ, WRITE), "vector not include READ and WRITE"
  end

  def test_not_include
    vector = BitVector.new(READ, WRITE)

    refute vector.include?(READ, WRITE, EXECUTE), "vector include EXECUTE"
  end

  def test_add
    vector = BitVector.new(READ)
    vector += WRITE

    assert vector.include?(READ, WRITE), "vector not include READ and WRITE"
  end

  def test_subtraction
    vector = BitVector.new(READ)
    vector -= READ

    refute vector.include?(READ), "vector include READ"
  end

  def test_to_i
    vector = BitVector.new(READ, WRITE)

    assert_equal 3, vector.to_i
  end

  def test_to_s
    vector = BitVector.new(READ, EXECUTE)

    assert_equal "101", vector.to_s
  end

  def test_inspect
    vector = BitVector.new(READ, EXECUTE)

    assert_equal "#<BitVector:101>", vector.inspect
  end

  def test_equal_equal
    actual = BitVector.new(READ, EXECUTE)
    expected = BitVector.new(READ, EXECUTE)

    assert actual == expected, "vectors not =="
  end

  def test_not_equal_equal
    actual = BitVector.new(READ, EXECUTE)
    expected = BitVector.new(READ)

    refute actual == expected, "vectors =="
  end

  def test_eql?
    actual = BitVector.new(READ, EXECUTE)
    expected = BitVector.new(READ, EXECUTE)

    assert actual.eql?(expected), "vectors not eql?"
  end

  def test_not_eql?
    actual = BitVector.new(READ, EXECUTE)
    expected = BitVector.new(READ)

    refute actual.eql?(expected), "vectors eql?"
  end

  def test_hash
    hash = {}
    hash[BitVector.new(READ, EXECUTE)] = true
    hash[BitVector.new(READ, EXECUTE)] = true
    hash[BitVector.new(READ)] = true

    assert_equal [
      BitVector.new(READ, EXECUTE),
      BitVector.new(READ)
    ], hash.keys
  end

  def test_none_constant
    assert_equal BitVector.new, BitVector::NONE
  end
end
