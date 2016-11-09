defmodule Tombola.PageController do
  use Tombola.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
