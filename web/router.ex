defmodule Watchnature.Router do
  use Watchnature.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Watchnature.Plug.CurrentUser
  end

  scope "/", Watchnature do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Watchnature do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
  end

  scope "/auth", Watchnature do
    pipe_through [:api, :api_auth]

    post "/identity/callback", AuthController, :indentity_callback
  end
end
