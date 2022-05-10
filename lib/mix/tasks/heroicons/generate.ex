defmodule Mix.Tasks.Heroicons.Generate do
  @moduledoc false

  @formats ["solid", "outline"]
  @requirements ["app.start"]

  use Mix.Task

  # Ignore that Req is not available during usage
  Code.put_compiler_option(:no_warn_undefined, [{Req, :get!, 1}])

  @impl Mix.Task
  def run([version]) when not is_nil(version) do
    case Version.parse(version) do
      {:ok, version} -> generate(@formats, version)
      :error -> IO.puts("Provided version number appears to be invalid")
    end

    # Format the files
    Mix.Tasks.Format.run(["lib/heroicons/*.ex"])
  end

  def run(_), do: IO.puts("Heroicons version required. E.g. mix generate 1.0.6")

  defp generate(formats, version) do
    Enum.each(formats, fn format ->
      download_icons(version)
      |> parse_icons(format)
      |> copy_template(format)
    end)
  end

  defp download_icons(version) do
    Req.get!("https://github.com/tailwindlabs/heroicons/archive/refs/tags/v#{version}.zip").body
  end

  defp parse_icons(icons, format) do
    icons
    |> Enum.map(fn {file, contents} -> {file |> to_string(), contents} end)
    |> filter_type(format)
    |> format_filename()
    |> modify_svg()
  end

  defp filter_type(icons, format) do
    Enum.filter(icons, fn {file, _} ->
      Regex.match?(
        ~r/.+\/optimized\/#{format}\/(.+)\.svg/,
        file
      )
    end)
  end

  defp format_filename(icons) do
    Enum.map(icons, fn {file, contents} ->
      %{"name" => name} =
        Regex.named_captures(
          ~r/.+\/(?<name>.+)\.svg/,
          file
        )

      {String.replace(name, "-", "_"), contents}
    end)
  end

  defp modify_svg(icons) do
    Enum.map(icons, fn {file, contents} ->
      {file,
       contents
       #  Add class and extra_attrs to svg wrapper
       |> String.replace("<svg", "<svg class={@class} {@extra_attrs}")
       # Strip newlines so the formatter doesn't complain about heredoc indentation
       |> String.replace("\n", "")}
    end)
  end

  defp copy_template(icons, format) do
    template = Application.app_dir(:phx_heroicons, "priv/templates/heroicons.ex")

    Mix.Generator.copy_template(
      template,
      "lib/heroicons/#{format}.ex",
      [icons: icons, format: format],
      force: true
    )
  end
end
