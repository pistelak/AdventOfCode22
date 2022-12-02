defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  @doc """
  #Examples
      iex> ["A Y", "B X", "C Z"]
      ...> |> Aoc.evaluate_first_part()
      15
  """
  def evaluate_first_part(input) do
    input
      |> preprocess_input()
      |> Enum.map(&Aoc.score/1)
      |> Enum.sum()
  end

  def evaluate_second_part(input) do
    input
      |> preprocess_input()
  end

  def score(["A", "X"]), do: 1 + 3
  def score(["B", "X"]), do: 1 + 0
  def score(["C", "X"]), do: 1 + 6

  def score(["A", "Y"]), do: 2 + 6
  def score(["B", "Y"]), do: 2 + 3
  def score(["C", "Y"]), do: 2 + 0

  def score(["A", "Z"]), do: 3 + 0
  def score(["B", "Z"]), do: 3 + 6
  def score(["C", "Z"]), do: 3 + 3

  @doc """
  ## Examples
      iex> ["A Y", "B X", "C Z"]
      ...> |> Aoc.preprocess_input
      [["A", "Y"], ["B", "X"], ["C", "Z"]]
  """
  def preprocess_input(input) do
    input
      |> Enum.map(fn x -> String.split(x, " ") end)
  end

end
