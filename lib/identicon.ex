defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grip
    |> filter_odd_squares
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    %Identicon.Image{image | grid:
      Enum.filter(grid, fn({code, _index}) -> rem(code, 2) == 0 end)
    }
  end

  def build_grip(%Identicon.Image{hex: hex} = image) do
    %Identicon.Image{image | grid:
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index
    }
  end

  def mirrow_row(row) do
    [first, second, _] = row
    row ++ [second, first]
  end

  def hash_input(input) do
    %Identicon.Image{hex:
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list
    }
  end

  def pick_color(%Identicon.Image{hex: [r, g ,b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end
