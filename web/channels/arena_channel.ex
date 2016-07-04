defmodule Countdown.ArenaChannel do
  use Phoenix.Channel

  alias Countdown.{Counter}

  def join("arenas:lobby", _payload, socket) do
    {:ok, %{counter: Counter.value}, socket}
  end

  def handle_in("count", _message, socket) do
    res = Counter.count
    value = Counter.value
    IO.inspect(res)

    message = case res do
      {:ok, value} -> %{won:  false, counter: value}
      {:overflow,value} -> %{won:  true, counter: value}
    end

    broadcast! socket, "update", %{counter: value}
    {:reply, {:ok, message}, socket}
   end

end
