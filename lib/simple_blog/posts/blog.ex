defmodule SimpleBlog.Posts.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :description, :string
    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :description, :tags])
    |> validate_required([:title, :description, :tags])
  end
end
