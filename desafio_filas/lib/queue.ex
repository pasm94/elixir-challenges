defmodule Queue do
  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def enqueue(pid, number) do
    GenServer.cast(pid, {:push, number})
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  # funcao sincrona
  def handle_call({:push, element}, _from, stack_state) do
    new_stack = [element | stack_state]
    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl true
  # funcao assincrona
  def handle_cast({:push, element}, stack_state) do
    {:noreply, [element | stack_state]}
  end
end
