defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  def evaluate_first_part(input) do
    instructions = input
      |> preprocess_input()

    cargo = %{
      1 => ["Z", "P", "M", "H", "R"],
      2 => ["P", "C", "J", "B"],
      3 => ["S", "N", "H", "G", "L", "C", "D"],
      4 => ["F", "T", "M", "D", "Q", "S", "R", "L"],
      5 => ["F", "S", "P", "Q", "B", "T", "Z", "M"],
      6 => ["T", "F", "S", "Z", "B", "G"],
      7 => ["N", "R", "V"],
      8 => ["P", "G", "L", "T", "D", "V", "C", "M"],
      9 => ["W", "Q", "N", "J", "F", "M", "L"],
    }

    Enum.reduce(instructions, cargo, fn i, c -> rearangment_procedure(c, i) end)
      |> Map.values()
      |> Enum.map(fn x -> Enum.take(x, -1) end)
      |> Enum.join

  end

  @doc """
    iex> Aoc.rearangment_procedure(%{ 1 => ["Z", "N", "D"], 2 => ["M", "C"], 3 => ["P"] }, [1, 2, 1])
    %{ 1 => ["Z", "N", "D", "C"], 2 => ["M"], 3 => ["P"] }
  """
  def rearangment_procedure(cargo, [amount, from, to]) do

    source = Map.get(cargo, from)
    crates = source |> Enum.take(-amount) # |> Enum.reverse() #Uncomment for the first part

    destination = Map.get(cargo, to)

    updated_source = Enum.drop(source, -amount)
    updated_destination = destination ++ crates

    cargo
      |> Map.put(from, updated_source)
      |> Map.put(to, updated_destination)
  end

  @doc """
  ## Examples
      iex> ["move 1 from 2 to 1", "move 3 from 1 to 3"]
      ...> |> Aoc.preprocess_input
      [[1, 2, 1], [3, 1, 3]]
  """
  def preprocess_input(input) do
    input |> Enum.map(&Aoc.preprocess_input_line/1)
  end

  @doc """
    iex> "move 13 from 1 to 3" |> Aoc.preprocess_input_line()
    [13, 1, 3]
  """
  def preprocess_input_line(input_line) do
    Regex.scan(~r/\d+/, input_line) |> List.flatten() |> Enum.map(&String.to_integer/1)
  end

end
