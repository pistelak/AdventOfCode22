defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  @doc """
  #Examples
      iex> ["2-4,6-8", "2-3,4-5", "5-7,7-9", "2-8,3-7", "6-6,4-6", "2-6,4-8"] |> Aoc.evaluate_first_part()
      2
  """
  def evaluate_first_part(input) do
    input
      |> preprocess_input()
      |> Enum.map(&Aoc.evaluate_intersection_on_one_line/1)
      |> Enum.sum
  end

  @doc """
  #Examples
      iex> [[2,8],[3,7]] |> Aoc.evaluate_intersection_on_one_line()
      1
      iex> [[6,6],[4,6]] |> Aoc.evaluate_intersection_on_one_line()
      1
  """
  def evaluate_intersection_on_one_line([[a,b],[c,d]]) do
    if (a <= c && b >= d) || (a >= c && b <= d) , do: 1, else: 0
  end

  @doc """
  #Examples
      iex> ["2-4,6-8", "2-3,4-5", "5-7,7-9", "2-8,3-7", "6-6,4-6", "2-6,4-8"] |> Aoc.evaluate_second_part()
      4
  """
  def evaluate_second_part(input) do
    input
      |> preprocess_input()
      |> Enum.map(&Aoc.evaluate_overlaps_on_one_line/1)
      |> Enum.sum
  end

  @doc """
  #Examples
      iex> [[2,4],[6,8]] |> Aoc.evaluate_overlaps_on_one_line()
      0
      iex> [[5,7],[7,9]] |> Aoc.evaluate_overlaps_on_one_line()
      1
  """
  def evaluate_overlaps_on_one_line([[a,b],[c,d]]) do
    first_elf = a..b |> MapSet.new
    second_elf = c..d |> MapSet.new
    intersection = MapSet.intersection(first_elf, second_elf) |> MapSet.to_list
    if length(intersection) > 0, do: 1, else: 0
  end

  @doc """
  ## Examples
      iex> ["2-4,6-8", "2-3,4-5"]
      ...> |> Aoc.preprocess_input
      [[[2,4], [6,8]],[[2,3], [4,5]]]
  """
  def preprocess_input(input) do
    input
      |>Enum.map(&Aoc.preprocess_one_line/1)
  end

  def preprocess_one_line(line) do
    line
      |> String.split([",", "-"], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
  end

end
