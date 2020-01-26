defmodule SimpleBlog.PostsTest do
  use SimpleBlog.DataCase

  alias SimpleBlog.Posts

  describe "blogs" do
    alias SimpleBlog.Posts.Blog

    @valid_attrs %{description: "some description", tags: [], title: "some title"}
    @update_attrs %{description: "some updated description", tags: [], title: "some updated title"}
    @invalid_attrs %{description: nil, tags: nil, title: nil}

    def blog_fixture(attrs \\ %{}) do
      {:ok, blog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_blog()

      blog
    end

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert Posts.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Posts.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      assert {:ok, %Blog{} = blog} = Posts.create_blog(@valid_attrs)
      assert blog.description == "some description"
      assert blog.tags == []
      assert blog.title == "some title"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{} = blog} = Posts.update_blog(blog, @update_attrs)
      assert blog.description == "some updated description"
      assert blog.tags == []
      assert blog.title == "some updated title"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_blog(blog, @invalid_attrs)
      assert blog == Posts.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Posts.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Posts.change_blog(blog)
    end
  end
end
