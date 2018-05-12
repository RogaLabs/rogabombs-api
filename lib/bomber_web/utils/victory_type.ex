defmodule VictoryType do
  @statuses %{1 => "standard", 2 => "golden", 3 => "flawless", 4=> "flawless_golden"}

  def get_int_status(status) do
    @statuses
    |> Enum.find({1,"standard"},fn {_key, value} -> value == status end)
    |> elem(0)

  end

  def get_str_status(status) do
    @statuses[status]
  end
end
