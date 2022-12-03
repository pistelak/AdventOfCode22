defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  @doc """
  #Examples
      iex> []
      ...> |> Aoc.evaluate_first_part()
      []
  """
  def evaluate_first_part(input) do
    input
      |> preprocess_input()
  end


  @doc """
  #Examples
      iex> []
      ...> |> Aoc.evaluate_second_part()
      []
  """
  def evaluate_second_part(input) do
    input
  end

  @doc """
  ## Examples
      iex> []
      ...> |> Aoc.preprocess_input
      []
  """
  def preprocess_input(input) do
    input
  end

end
