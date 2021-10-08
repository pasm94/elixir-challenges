defmodule Gitapi do
  alias Gitapi.Github.Client, as: GetGithubRepositories

  defdelegate get_user_repositories(), to: GetGithubRepositories, as: :get_user_repos
  defdelegate get_user_repositories(user_name), to: GetGithubRepositories, as: :get_user_repos
end
