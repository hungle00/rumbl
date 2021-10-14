alias Rumbl.Repo
alias Rumbl.Accounts.User

for u <- Repo.preload(Repo.all(User), :credential) do
  Repo.update!(User.registration_changeset(u, %{
    credential: %{email: "#{u.username}@example.com", password: "temppass"}}))
end
