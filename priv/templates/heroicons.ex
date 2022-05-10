defmodule Heroicons.<%= String.capitalize(@format) %> do
  @moduledoc false

  use Phoenix.Component

  @default_class "flex-shrink-0 h-5 w-5"
  <%= for {name, svg} <- @icons do %>
  @doc "<%= name %>"
  def <%= name %>(assigns) do
    assigns = default_assigns(assigns)

    ~H"""
    <%= svg %>
    """
  end
  <% end %>
  defp default_assigns(assigns) do
    # Get all the extra attributes that might have been passed in
    # With the exception of class, which is initialized to a default value
    extra_attrs = assigns_to_attributes(assigns, [:class])

    # Assign a default class only if one was not provided
    assign_new(assigns, :class, fn -> @default_class end)
    |> assign(:extra_attrs, extra_attrs)
  end
end
