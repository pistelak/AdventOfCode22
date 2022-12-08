defmodule Aoc do

  defmodule Tree do
    defstruct height: 0, visible: false, score: []
  end

  def read_file(file_name) do
    File.read!(file_name)
      |> String.split("\n")
  end

  def evaluate_first_part() do
    "input"
      |> read_file()
      |> preprocess_input()
      |> map_over_trees(&Aoc.mark_visible_trees_in_line/1)
      |> List.flatten()
      |> Enum.count(& &1.visible)
  end

  def map_over_trees(forest, function) do
    forest |> Enum.map(function) |> transpose() |> Enum.map(function) |> transpose()
  end

  def mark_visible_trees_in_line(line) do
    mark_visible_trees_in_line(line, [])
  end

  def mark_visible_trees_in_line([head|tail], acc) do
    marked_tree = %Tree{head | visible: is_visible?(head, tail) || is_visible?(head, acc) || head.visible}
    mark_visible_trees_in_line(tail, [marked_tree|acc])
  end

  def mark_visible_trees_in_line([], acc), do: Enum.reverse(acc)

  def is_visible?(tree, line) do
    Enum.all?(line, fn tree_in_line -> tree_in_line < tree end)
  end

  def evaluate_second_part() do
    "input"
      |> read_file()
      |> preprocess_input()
      |> map_over_trees(&Aoc.count_scenic_score_in_line/1)
      |> List.flatten()
      |> Enum.map(& &1.score)
      |> Enum.map(&Enum.product/1)
      |> Enum.max
  end

  def count_scenic_score_in_line(forest) do
    count_scenic_score_in_line(forest, [])
  end

  def count_scenic_score_in_line([head|tail], acc) do
    counted_tree = %Tree{head | score: [visibility(head, tail), visibility(head, acc) | head.score] }
    count_scenic_score_in_line(tail, [counted_tree|acc])
  end

  def count_scenic_score_in_line([], acc), do: Enum.reverse(acc)

  def visibility(tree, line_of_trees) do
    if Enum.all?(line_of_trees, fn tree_in_line -> tree_in_line.height < tree.height end) do
      Enum.count(line_of_trees)
    else
      smaller_trees = Enum.take_while(line_of_trees, fn tree_in_line -> tree_in_line.height < tree.height end)
      Enum.count(smaller_trees) + 1
    end
  end

  def preprocess_input(input) do
    input
      |> Enum.map(fn row ->
        row
          |> String.graphemes
          |> Enum.map(&String.to_integer/1)
          |> Enum.map(fn tree ->
              %Tree{height: tree, visible: false}
          end)
      end)
  end

  def transpose(board) do
    board |> Enum.zip |> Enum.map(&Tuple.to_list/1)
  end

end
