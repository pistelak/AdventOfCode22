defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end


  def evaluate_first_part(input) do
    input
      |> preprocess_input()
      |> sum_calories_carreid_by_top_elf()
  end

  def evaluate_second_part(input) do
    input
      |> preprocess_input()
      |> sum_calories_carried_by_top_three_elves()
  end

  @doc """
  ## Examples
      iex> [[1, 2], [3, 1]]
      ...> |> Aoc.sum_calories_carreid_by_top_elf
      4
  """
  def sum_calories_carreid_by_top_elf(preprocessed_input) do
    preprocessed_input
      |> Enum.map(&Enum.sum/1)
      |> Enum.max
  end

  @doc """
  ## Examples
      iex> [[1, 2], [3, 1], [4, 3], [5, 2]]
      ...> |> Aoc.sum_calories_carried_by_top_three_elves
      18
  """
  def sum_calories_carried_by_top_three_elves(preprocessed_input) do
    preprocessed_input
      |> Enum.map(&Enum.sum/1)
      |> Enum.sort(:desc)
      |> Enum.take(3)
      |> Enum.sum()
  end

  @doc """
  ## Examples
      iex> ["1", "2", "", "3", "1"]
      ...> |> Aoc.preprocess_input
      [[1, 2], [3, 1]]
  """
  def preprocess_input(input) do
    input
    |> Enum.chunk_by(fn x -> x == "" end)
    |> Enum.reject(fn x -> x == [""] end)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end

end
