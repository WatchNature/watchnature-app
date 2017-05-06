defmodule Watchnature.PageControllerTest do
  use Watchnature.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Watch Nature"
  end
end
