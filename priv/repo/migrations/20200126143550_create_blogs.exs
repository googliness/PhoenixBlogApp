defmodule SimpleBlog.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :description, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
