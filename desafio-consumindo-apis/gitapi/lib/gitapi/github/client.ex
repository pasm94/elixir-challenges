defmodule Gitapi.Github.Client do
  use Tesla

  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.JSON

  def get_user_repos(user) do
    with {:ok, %Tesla.Env{body: repositories}} = Tesla.get("#{@base_url}#{user}/repos") do
      repositories
      |> Poison.decode!()
      |> Enum.map(fn %{"name" => names} -> names end)
    end
  end

  def get_user_repos() do
    with {:ok, %Tesla.Env{body: repositories}} = Tesla.get("#{@base_url}pasm94/repos") do
      repositories
      |> Poison.decode!()
      |> Enum.map(fn %{"name" => names} -> names end)
    end
  end
end
