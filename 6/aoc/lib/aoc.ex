defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  @doc """
    Returns the first position where the four most recently received characters
    were all different

    iex> ["mjqjpqmgbljsphdztnvjfqwrcgsmlb"] |> Aoc.evaluate_first_part()
    7
    iex> ["bvwbjplbgvbhsrlpgdmjqwftvncz"] |> Aoc.evaluate_first_part()
    5
    iex> ["nppdvjthqldpwncqszvftbrmjlhg"] |> Aoc.evaluate_first_part()
    6
    iex> ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"] |> Aoc.evaluate_first_part()
    10
    iex> ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"] |> Aoc.evaluate_first_part()
    11
   """
  def evaluate_first_part(input) do
    input
      |> List.first
      |> String.graphemes()
      |> sliding_window(0, 4, false)
  end

    @doc """
    iex> ["mjqjpqmgbljsphdztnvjfqwrcgsmlb"] |> Aoc.evaluate_second_part()
    19
    iex> ["bvwbjplbgvbhsrlpgdmjqwftvncz"] |> Aoc.evaluate_second_part()
    23
    iex> ["nppdvjthqldpwncqszvftbrmjlhg"] |> Aoc.evaluate_second_part()
    23
    iex> ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"] |> Aoc.evaluate_second_part()
    29
    iex> ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"] |> Aoc.evaluate_second_part()
    26
   """
  def evaluate_second_part(input) do
    input
      |> List.first
      |> String.graphemes()
      |> sliding_window(0, 14, false)
  end
  def sliding_window(_, cursor, _, true) do
    cursor - 1
  end

  def sliding_window(datastream, cursor, window_size, is_marker) when cursor < window_size do
    sliding_window(datastream, cursor + 1, window_size, is_marker)
  end

  def sliding_window(datastream, cursor, window_size, _) do
    letters = datastream
      |> Enum.take(cursor)
      |> Enum.take(-window_size)

    sliding_window(datastream, cursor + 1, window_size, is_marker?(letters))
  end

  def is_marker?(letters) do
    letters
      |> Enum.frequencies()
      |> Map.values
      |> Enum.max == 1
  end

end
