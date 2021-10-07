defmodule GitapiWeb.GithubController do
  use GitapiWeb, :controller

  def index(conn, _params) do
    rest = Gitapi.Github.Client.get_user_repos()

    conn
    |> put_status(:ok)
    |> text(rest)
  end
end
