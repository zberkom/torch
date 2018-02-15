defmodule Torch.Router do
  @moduledoc """
  Creates routes to expose compiled torch stylesheets and js

  Typically, you'll add this to your `my_app_web.ex` file, under the `router`
  function:

      def router do
        quote do
          use Phoenix.Router
          use Torch.Router
          # ...
        end
      end

  If you'd prefer, you can remove it from `my_app_web.ex` and add it to the router
  yourself:
      defmodule MyApp.Router do
        use Torch.Router
        # ...
  """
  defmacro __using__(_env) do
    quote do
      pipeline :torch_pipeline do
        plug(
          Plug.Static,
          at: "/torch",
          from: {:torch, "priv/static"},
          gzip: true,
          cache_control_for_etags: "public, max-age=86400",
          headers: [{"access-control-allow-origin", "*"}]
        )

        plug(:fetch_session)
        plug(:fetch_flash)
        plug(:put_secure_browser_headers)
      end

      scope "/torch", Torch do
        pipe_through(:torch_pipeline)

        get("/torch.js", AssetsController, :assets)
        get("/base.css", AssetsController, :assets)
        get("/theme.css", AssetsController, :assets)
        get("/torch-logo.png", AssetsController, :assets)
        get("/down-arrow.png", AssetsController, :assets)
      end
    end
  end
end