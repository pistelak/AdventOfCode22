defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  describe "avaluate_first_part/1" do

    test "when run with test input then it should return correct result" do
      test_input_result = Aoc.read_file("test_input") |> Aoc.evaluate_first_part()
      assert test_input_result == 13140
    end

    test "when run with input then it should return correct result" do
      test_input_result = Aoc.read_file("input") |> Aoc.evaluate_first_part()
      assert test_input_result == 14620
    end

  end
end
