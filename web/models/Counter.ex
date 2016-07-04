defmodule Countdown.Counter do

  @reset 0
  @limit 100

  # el supervisor en countdown.ex arranca el proceso hijo Countdown.Counter
  # el proceso hijo necesita la funcion start_link
  def start_link do
    Agent.start_link(fn -> @reset end, name: __MODULE__)
  end

  def reset() do
    Agent.update(__MODULE__, fn(n)-> @reset end)
  end


  def value() do
     Agent.get(__MODULE__, fn(n)-> n end)
  end


  def limit() do
     @limit
  end

  def count() do
    # aux = value + 1
    # Agent.update(__MODULE__, fn(n)-> aux end)
    set(value+1)
    if (value == @limit) do
      reset
      {:overflow, @reset}
    else
      {:ok, value}
    end
  end


   def set(val) do
     Agent.update(__MODULE__, fn(n) -> val end)
   end

end
