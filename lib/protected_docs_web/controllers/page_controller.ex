defmodule ProtectedDocsWeb.PageController do
  use ProtectedDocsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
