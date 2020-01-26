defmodule SimpleBlogWeb.UserController do
  use SimpleBlogWeb, :controller

  alias SimpleBlog.Accounts
  alias SimpleBlog.Accounts.User


  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:session_user_id, user.id)
        |> put_flash(:info, "Registration Successfull.")
        |> redirect(to: Routes.blog_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
