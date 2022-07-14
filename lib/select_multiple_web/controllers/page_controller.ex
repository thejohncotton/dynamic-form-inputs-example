defmodule SelectMultipleWeb.PageController do
  use SelectMultipleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
