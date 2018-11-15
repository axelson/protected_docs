defmodule ProtectedDocsWeb.MissingProtectedPageController do
  use ProtectedDocsWeb, :controller

  def index(conn, _params) do
    # Treat this like a 404 since it means that there wasn't a file to render
    text(conn, "404")
  end
end
