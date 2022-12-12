defmodule Aoc do

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  def evaluate_first_part do
    read_file("input")
      |> process_input()
      |> Enum.filter(fn e -> e < 100000 end)
      |> Enum.sum
  end

  def evaluate_second_part do
    [root | other_directories] = read_file("input")
      |> process_input()

    filesystem_size = 70_000_000
    needs_to_be_free = 30_000_000
    needed = root - (filesystem_size - needs_to_be_free)

    other_directories
      |> Enum.filter(fn d -> d >= needed end)
      |> Enum.min
  end

  def process_input(input) do
    process_input(input, [], [])
  end

  @doc """
    Parameters
      - First represents *terminal output*.
      - Second represents *size of directories on current path*
      - Third represents *size of already "visited" directories*
    Returns
      - *list of directory sizes*.
  """
  @spec process_input([String.t], [Integer.t], [Integer.t]) :: [Integer.t]
  def process_input(["$ cd .." | tail], [current, parent | parents] = _pwd, visited) do
    process_input(tail, [current + parent | parents], [current | visited])
  end

  def process_input(["$ cd " <> _ | tail], pwd, visited) do
    process_input(tail, [0 | pwd], visited)
  end

  def process_input(["$ ls" | tail], parents, visited) do
    process_input(tail, parents, visited)
  end

  def process_input(["dir " <> _ | tail], parents, visited) do
    process_input(tail, parents, visited)
  end

  def process_input([file_info | tail], [current | parents], visited) do
    [file_size | _] = String.split(file_info, " ")
    process_input(tail, [current + String.to_integer(file_size) | parents], visited)
  end

  def process_input([], [current, parent | parents], visited) do
    process_input([], [current + parent | parents], [current | visited])
  end

  def process_input([], [root], visited) do
    [root | visited]
  end

  def process_input([], [], visited) do
   visited
  end

end
