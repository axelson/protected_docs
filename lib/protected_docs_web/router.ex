defmodule ProtectedDocsWeb.Router do
  use ProtectedDocsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug :fetch_session
    plug :put_secure_browser_headers
    plug ProtectedDocsWeb.Plug.ProtectedPlug
    plug Plug.Static,
      at: "/docs", from: {:protected_docs, "priv/private"}, gzip: false
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProtectedDocsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/handle_login", LoginController, :handle_login
    get "/redirected", LoginController, :redirected
  end

  scope "/docs", ProtectedDocsWeb do
    pipe_through :protected
    match :*, "/*route", MissingProtectedPageController, :index
  end
end
