defmodule GitapiWeb.GithubController do
  use GitapiWeb, :controller

  def index(conn, _params) do
    response = %{repositories: Gitapi.Github.Client.get_user_repos()}

    conn
    |> put_status(:ok)
    |> text(Poison.encode!(response))
  end
end
