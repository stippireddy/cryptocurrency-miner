defmodule CryptoCurrencyTest do
  use ExUnit.Case
  doctest CryptoCurrency

  test "greets the world" do
    assert CryptoCurrency.hello() == :world
  end
end
