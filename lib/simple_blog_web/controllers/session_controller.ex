defmodule SimpleBlogWeb.SessionController do
  use SimpleBlogWeb, :controller
  alias SimpleBlog.Accounts

  def new(conn, params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    user = Accounts.get_by_username(auth_params["username"])
    if user.encrypted_password == auth_params["password"] do
      conn
      |> put_session(:session_user_id, user.id)
      |> put_flash(:info, "Signed in successfully.")
      |> redirect(to: Routes.blog_path(conn, :index))
    else
      conn
      |> put_flash(:error, "There was a problem with your username/password")
      |> render("new.html")
    end
  end

  def delete(conn, params) do
    conn
    |> delete_session(:session_user_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: Routes.blog_path(conn, :index))
  end
end