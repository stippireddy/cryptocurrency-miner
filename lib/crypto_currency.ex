defmodule BootStrap do
  
  @moduledoc """
  Documentation for CryptoCurrency.
  """

  def main(args \\ []) do
    IO.inspect args
    if !String.contains?(Enum.at(args,1), ".") do
      master_ip = Enum.at(args,0)
      IO.inspect master_ip
      _ = System.cmd("epmd", ["-daemon"])
      Node.start(String.to_atom("foo@"<> master_ip))
      IO.inspect Application.get_env(:crypto_currency, :cookie)
      Node.set_cookie Node.self, Application.get_env(:crypto_currency, :cookie)
      CryptoSupervisor.start_link([Enum.at(args, 1)])
      :timer.sleep(10000)
      pid = :global.whereis_name(:mas) 
      IO.inspect Master.get_message(pid, []) 
    else
      master_ip = Enum.at(args,0)
      slave_ip = Enum.at(args,1)
      _ = System.cmd("epmd", ["-daemon"])
      Node.start(String.to_atom("bar@"<> slave_ip))
      IO.inspect Application.get_env(:crypto_currency, :cookie)
      Node.set_cookie Node.self, Application.get_env(:crypto_currency, :cookie)
      status = Node.connect(String.to_atom("foo@"<> master_ip))
      IO.puts status
      if status do
        w=10
        k=[Enum.at(args, 2)]
        pids = Enum.map(1..w, fn(_) -> Slave.start_link(k) end)
        IO.inspect pids
        :timer.sleep(10000)
        pid = :global.whereis_name(:mas) 
        IO.inspect Master.get_message(pid, [])
      else
        IO.puts "Connection Failed"
      end
    end
  end
end