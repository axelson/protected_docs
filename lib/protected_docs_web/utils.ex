defmodule ProtectedDocsWeb.Utils do
  alias OAuth2.AccessToken

  def logged_in?(conn) do
    conn
    |> Plug.Conn.get_session(:access_token)
    |> valid_token?()
  end

  def valid_token?(nil), do: false

  def valid_token?(%AccessToken{} = token) do
    !AccessToken.expired?(token)
  end
end
