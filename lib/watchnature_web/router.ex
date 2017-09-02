defmodule WatchnatureWeb.Router do
  use WatchnatureWeb, :router

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

  scope "/api", WatchnatureWeb do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit, :create, :update, :delete]
    resources "/media", MediaController, only: [:create]

    resources "/posts", PostController, except: [:new, :edit] do
      resources "/observations", ObservationController, except: [:new, :edit] do
        post "/like", Observation.ObservationLikeController, :create
        delete "/like", Observation.ObservationLikeController, :delete
        resources "/images", Observation.ObservationImageController, only: [:index, :create, :delete]
      end
      resources "/comments", CommentController, except: [:new, :edit]
    end

    resources "/species", SpeciesController, only: [:index]
  end

  scope "/auth", WatchnatureWeb do
    pipe_through [:api, :api_auth]

    post "/identity/callback", AuthController, :indentity_callback
  end
end
