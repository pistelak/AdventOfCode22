defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  @doc """
    iex> ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"] |> Aoc.evaluate_first_part()
    157
  """
  def evaluate_first_part(input) do
    input
      |> Enum.map(&Aoc.evaluate_one_rucksack/1)
      |> Enum.sum
  end

  @doc """
    iex> "vJrwpWtwJgWrhcsFMMfFFhFp" |> Aoc.evaluate_one_rucksack()
    16
  """
  def evaluate_one_rucksack(rucksack) do
    rucksack
      |> split_to_compartments
      |> compartments_to_priorities
      |> common_elements
  end

  @doc """
    iex> [[1, 2, 3], [3, 4, 5]] |> Aoc.common_elements
    3
  """
  def common_elements(compartments) do
    [initial|_] = compartments
    Enum.reduce(compartments, initial, fn compartment, acc ->
      a = MapSet.new(compartment)
      b = MapSet.new(acc)
      MapSet.intersection(a, b) |> MapSet.to_list
    end) |> List.first
  end

  @doc """
  #Examples
      iex> "vJrwpWtwJgWrhcsFMMfFFhFp"
      ...> |> Aoc.split_to_compartments()
      [
        ["v", "J", "r", "w", "p", "W", "t", "w", "J", "g", "W", "r"],
        ["h", "c", "s", "F", "M", "M", "f", "F", "F", "h", "F", "p"]
      ]
  """
  def split_to_compartments(supplies) do
    items = supplies |> String.graphemes()
    pivot = length(items)/2 |> round
    items |> Enum.chunk_every(pivot)
  end

  def compartments_to_priorities(compartments) do
    compartments
      |> Enum.map(&Aoc.compartment_items_to_priorities/1)
  end

  def compartment_items_to_priorities(items) do
    items
      |> Enum.map(&Aoc.compartment_item_to_priority/1)
  end

  @doc """
  #Examples
      iex> "a" |> Aoc.compartment_item_to_priority
      1
      iex> "z" |> Aoc.compartment_item_to_priority
      26
      iex> "A" |> Aoc.compartment_item_to_priority
      27
      iex> "Z" |> Aoc.compartment_item_to_priority
      52
  """
  def compartment_item_to_priority(item) do
    ascii_value = :binary.first(item)
    if ascii_value >= 97, do: ascii_value - 96, else: ascii_value - 38
  end

  @doc """
    iex> ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"] |> Aoc.evaluate_second_part()
    70
  """
  def evaluate_second_part(input) do
    input
      |> Enum.chunk_every(3)
      |> Enum.map(&Aoc.find_badge_in_group/1)
      |> Enum.map(&Aoc.compartment_item_to_priority/1)
      |> Enum.sum
  end

  @doc """
    iex> ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL" , "PmmdzqPrVvPwwTWBwg"] |> Aoc.find_badge_in_group()
    "r"
  """
  def find_badge_in_group(group) do
    group
      |> Enum.map(&String.graphemes/1)
      |> common_elements()
  end
end
