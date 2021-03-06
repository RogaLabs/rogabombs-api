defmodule BomberWeb.Router do
  use BomberWeb, :router

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

  scope "/", BomberWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BomberWeb do
    pipe_through :api
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/matches", MatchController, except: [:new, :edit]
    resources "/matches_plays", MatchPlayController, except: [:new, :edit, :delete, :update]
    get "/dashboard/fame", PlayerController, :hall_of_fame
    get "/dashboard/shame", PlayerController, :hall_of_shame
    get "/last_match", MatchController, :last_match
  end
end
