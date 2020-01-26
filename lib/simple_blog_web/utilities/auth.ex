defmodule SimpleBlogWeb.Helpers.Auth do

  def is_signed_in(conn) do
    user_id = Plug.Conn.get_session(conn, :session_user_id)
    if user_id, do: !!SimpleBlog.Repo.get(SimpleBlog.Accounts.User, user_id)
  end

end