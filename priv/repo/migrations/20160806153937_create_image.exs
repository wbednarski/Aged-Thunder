defmodule AgedThunder.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :name, :string
      add :desc, :string
      add :attachment, :string

      timestamps()
    end

  end
end
