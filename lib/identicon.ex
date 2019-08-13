defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grip
  end

  def build_grip(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirrow_row/1)
  end

  def mirrow_row(row) do
    [first, second, _] = row
    row ++ [second, first]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g ,b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end
