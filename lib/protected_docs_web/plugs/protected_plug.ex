defmodule ProtectedDocsWeb.Plug.ProtectedPlug do
  def init(_) do
    :ok
  end

  def call(conn, _opts) do
    if ProtectedDocsWeb.Utils.logged_in?(conn) do
      conn
    else
      Phoenix.Controller.redirect(conn, external: ProtectedDocs.GitHubOAuthStrategy.authorize_url!())
    end
  end
end
