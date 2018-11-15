defmodule ProtectedDocsWeb.LoginController do
  use ProtectedDocsWeb, :controller
  # https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#2-users-are-redirected-back-to-your-site-by-github
  # Need to take the `code` that was passed in as a Query param and do a
  # POST https://github.com/login/oauth/access_token
  # to get an access token, then we store it in the session and redirect the user to the protected docs

  def handle_login(conn, %{"code" => code}) do
    %OAuth2.Client{
      token: token
    } = ProtectedDocs.GitHubOAuthStrategy.get_token!(code: code)
    IO.inspect(token, label: "handle_login token")

    handle_token(conn, token)
  end

  def handle_login(conn, _params) do
    # TODO: Render error
    conn
    |> put_status(422)
    |> text("Unable to login")
  end

  defp handle_token(conn, %OAuth2.AccessToken{other_params: %{"error" => error_slug}}) do
    case error_slug do
      "bad_verification_code" ->
        conn
        |> text("Bad verification code")
      _ ->
        conn
        |> text("Unknown error with token")
    end
  end

  defp handle_token(conn, %OAuth2.AccessToken{access_token: access_token} = token) when not is_nil(access_token) do
    conn
    |> put_session(:access_token, token)
    |> redirect(to: "/docs/index.html")
  end
end
