# Copyright (c) 2006 Zed A. Shaw 
# You can redistribute it and/or modify it under the same terms as Ruby.

require 'test/unit'
require 'profligacy/lel'

class LELParserTest < Test::Unit::TestCase
  include Profligacy

  def setup
    @listener = LELNameScanner.new
    @lel = LELParser.new
    @tests = {
      "[(100)a|(100,200)b]" => 2,
      "[*(100,100)a|b]" => 2,
      "[*a|*b|*c][*d]" => 4,
      "[<(100)a|>(100)b|<(100,200)c|>(100,200)d]" => 4,
      "[<a|>b][>c|<d]" => 4,
      "[^a|.b][.c|^d]" => 4,
      "[_|a]" => 2,
      "[a_1|b_2yeah]" => 2,
      "[apples_1always|oranges_2sometimes]" => 2,
      "[apples|oranges]" => 2,
      "[a|b|c|d][e|f][g]" => 7,
    }

    @failures = [
      "[b.|d]", "[_|a*]", "[b(100)|_]", 
      "[c(100,100)|_]",
      "[|]", "[a<|b]", "[b>|c]", "[b^|d]",
    ]
  end

  def test_successes
    @tests.each do |expr, result|
      assert @lel.scan(expr, @listener)
      assert_equal result, @listener.children.length
      @listener.children.clear
    end
  end

  def test_failures
    @failures.each do |expr|
      assert !@lel.scan(expr, @listener)
    end
    @listener.children.clear
  end
end

