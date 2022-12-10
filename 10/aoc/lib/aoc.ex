defmodule Aoc do

  defmodule Instruction do
    defstruct cycle: 1, instruction: "", x: 1
  end

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  def evaluate_first_part(input) do
    input
      |> run_program()
      |> Enum.filter(fn instruction -> Enum.member?([20, 60, 100, 140, 180, 220], instruction.cycle) end)
      |> Enum.map(fn i -> i.cycle * i.x end)
      |> Enum.sum
  end

  def run_program(instruction_list) do
    run(instruction_list, 1, [], 1)
  end

  def run(["noop" | tail], cycle, acc, x) do
    updated_acc = %Instruction{cycle: cycle, instruction: "noop", x: x}
    run(tail, cycle + 1, acc ++ [updated_acc], x)
  end

  def run(["addx " <> number | tail], cycle, acc, x) do
    updated_acc = [
      %Instruction{cycle: cycle, instruction: "start - addx #{number}", x: x },
      %Instruction{cycle: cycle + 1, instruction: "execution - addx #{number}", x: x }
    ]
    run(tail, cycle + 2, acc ++ updated_acc, x + String.to_integer(number))
  end

  def run([], _, acc, _) do
    acc
  end

  def evaluate_second_part(input) do
    input
    |> run_program()
    |> Enum.map(fn i -> if Enum.member?(i.x-1..i.x+1, rem(i.cycle - 1, 40)), do: "#", else: "." end)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
  end

end
