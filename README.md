# Timezone

[![CircleCI](https://circleci.com/gh/Schultzer/timezone.svg?style=svg)](https://circleci.com/gh/Schultzer/timezone)

Simple wrapper around Google Maps Time Zone API

## Examples

```elixir
  iex> Timezone.lookup(13.739626, 100.560907)
  {:ok, "Asia/Bangkok"}

  iex> Timezone.lookup("13.739626", "100.560907")
  {:ok, "Asia/Bangkok"}

  iex> Timezone.lookup(Decimal.new(13.739626), Decimal.new("100.560907"))
  {:ok, "Asia/Bangkok"}
```

## Installation

```elixir
def deps do
  [
    {:timezone, "~> 0.2"}
  ]
end
```

## Configuration

```elixir
config :timezone,
  api_key: System.get_env("GOOGLE_API_KEY")
```

## Documentation

[https://hexdocs.pm/timezone](https://hexdocs.pm/timezone)

## LICENSE

(The MIT License)

Copyright (c) 2017 Benjamin Schultzer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
