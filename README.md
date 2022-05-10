# Heroicons for Phoenix LiveView

[Heroicons](https://heroicons.com/) components for [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view).

## Why this one?

1. Most other available packages load the SVG files from disk. This package generates heex components which are precompiled and therefore very fast.
2. The generated components can be customized with custom classes and additional attributes (see [Usage](#usage)).
3. The package can be easily updated by running `mix heroicons.generate HEROICONS_VERSION`. No external deps like `npm` are required to keep it current.

Docs can be found at <https://hexdocs.pm/heroicons>.

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
