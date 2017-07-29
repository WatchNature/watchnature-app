defmodule Watchnature.Web.Router do
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

  scope "/api", Watchnature.Web do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit, :create, :update, :delete]
    resources "/media", MediaController, only: [:create]

    resources "/posts", PostController, except: [:new, :edit] do
      resources "/observations", ObservationController, except: [:new, :edit] do
        resources "/images", Observation.ObservationImageController, only: [:index, :create, :delete]
      end
      resources "/comments", CommentController, except: [:new, :edit]
    end
  end

  scope "/auth", Watchnature.Web do
    pipe_through [:api, :api_auth]

    post "/identity/callback", AuthController, :indentity_callback
  end

  # Setup browser pipe to catch all URLS and forward to the SPA page.
  # Note: This should stay at the bottom so all api/auth routes are matched first
  scope "/", Watchnature.Web do
    pipe_through :browser
    get "/*path", PageController, :index
  end
end
