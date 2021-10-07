defmodule Gitapi do
  alias Gitapi.Github.Client, as: GetGithubRepo

  defdelegate user_repo(), to: GetGithubRepo, as: :get_user_repos
end
