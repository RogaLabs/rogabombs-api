defmodule BomberWeb.PageController do
  use BomberWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
