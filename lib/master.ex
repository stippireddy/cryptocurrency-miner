defmodule Master do
    use GenServer

    def start_link(opts) do
        IO.puts "*********** Master up and running ********"
        {:ok, pid} = GenServer.start_link(__MODULE__,opts)
        :global.register_name(:mas, pid)
        w = 1
        k = [opts] 
        Enum.map(1..w, fn(_) -> Slave.start_link(k) end)
        {:ok, pid}
    end

    def set_message(server, name) do
        GenServer.cast(server, {:set_message, name})
    end

    def get_message(server, name) do
        GenServer.call(server, {:get_message, name})
    end

    #callbacks
    def init(opts) do
        #IO.puts "ccc"
        names = []
        {:ok, names}
    end

    def handle_cast({:set_message, name},names) do
        names = names ++ name
        IO.puts name
        {:noreply,names}
    end

    def handle_call({:get_message, name}, _from, names) do
        {:reply, names, names}
    end
end
