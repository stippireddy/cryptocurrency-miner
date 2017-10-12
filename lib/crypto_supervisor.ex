defmodule CryptoSupervisor do
	use Supervisor

	@name CryptoSupervisor
	
	def start_link(args) do
		Supervisor.start_link(__MODULE__,args, name: @name)
	end

	def init(args) do
		#k = Enum.at(args,0)
		#IO.inspect args
		children = [ 
			worker(Master, args)
		]
		supervise(children, strategy: :one_for_one)		
	end
end
