# CryptoCurrency

This is an actor model implementation of a Cryptocurrency Miner using Elixir.

## Steps to run

1. mix compile
2. mix escript.build
3. escript crypto_currency master_node_ip [slave_node_ip] length_of_zeroes

Note: The slave_node_ip is only required when you intend to add the current machine to 
an already running master.

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `crypto_currency` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:crypto_currency, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/crypto_currency](https://hexdocs.pm/crypto_currency).

