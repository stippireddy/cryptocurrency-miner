defmodule Slave do
	use GenServer

	def start_link(opts) do
		{:ok, pid} = GenServer.start_link(__MODULE__, opts)
        {k,_}= Integer.parse(Enum.at(opts,0))
        len=10
        l = [k,len]
        pidm = :global.whereis_name(:mas)
        tup = {pidm, l}
        Slave.set_message(pid, tup)
        {:ok, pid}
	end

    def start_work(server,name) do
    	GenServer.cast(server,{:start_work, name})
    end

    def set_message(server, tup) do
    	out = GenServer.cast(server, {:set_message, tup})
        p = Enum.at(elem(tup,1),0)
        opts = Integer.to_string(p)
        k = [opts]
        start_link(k)
        out
    end

    def get_message(server, pid) do
        GenServer.call(server, {:get_message, pid})
    end

    #callbacks
    def init(_) do
    	names = []
    	{:ok, names}
    end

    def handle_cast({:set_message, tup}, names) do
    	#IO.puts "Called cast"
        str = find_string(Enum.at(elem(tup,1),0), Enum.at(elem(tup,1),1))
    	pidM = elem(tup,0)
        Master.set_message(pidM, [str])
        {:noreply,names}
    end


    def handle_call({:get_message, _}, _from, names) do
        {:reply, names, names}
    end

    defp find_string(number_of_zeroes, length) do
        s = "stippireddy" <> random_string length
        hash = :crypto.hash(:sha256, s) |> Base.encode16
        if (String.starts_with? hash, String.duplicate("0",number_of_zeroes)) do
          s <> "\t" <>hash
        else
          find_string(number_of_zeroes, length)
        end 
    end

    defp random_string(length) do
      :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
    end
end