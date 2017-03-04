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

  scope "/", Watchnature do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Watchnature do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostsController, except: [:new, :edit]
  end
end
