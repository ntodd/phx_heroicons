# Heroicons Components for Phoenix LiveView

[Heroicons](https://heroicons.com/) components for [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view).

Docs can be found at <https://hexdocs.pm/phx_heroicons>.

## Installation

```elixir
def deps do
  [
    {:phx_heroicons, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
# Use default class of "flex-shrink-0 h-5 w-5"
<Heroicons.Solid.home />

# Use outline version
<Heroicons.Outline.home />

# Override with a custom class
<Heroicons.Solid.home class="h-8 w-8"/>

# Any custom attributes will be passed to the <svg> tag
<Heroicons.Solid.home class="h-8 w-8" x-show="open"/>
```
