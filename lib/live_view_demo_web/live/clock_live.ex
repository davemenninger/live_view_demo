defmodule LiveViewDemoWeb.ClockLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
    <div>
      <h2 phx-click="boom">It's <%= strftime!(@date, "%r") %></h2>
      <h2 phx-click="boom">It's <%= Calendar.DateTime.Format.unix(@date) %></h2>
    </div>
    <div>
			<svg viewBox="0 0 640 480" xmlns="http://www.w3.org/2000/svg" stroke="red" fill="grey">
        <%= for {px,py} <- @planets do %>
          <circle cx="<%= px %>" cy="<%= py %>" r="40" >
        <% end %>
			</svg>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_date(socket) |> put_planets }
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket) |> put_planets }
  end

  defp put_date(socket) do
    assign(socket, date: Calendar.DateTime.now!("UTC"))
  end

  defp put_planets(socket) do
    assign(socket, planets: planets() )
  end

  defp planets do
    [
      position_of_planet
    ]
  end

  defp position_of_planet do
    tick_angle = ( :math.pi * 2 )  / 48
    position = rem(
      Calendar.DateTime.Format.unix(
        Calendar.DateTime.now!("UTC")
      ),
      48
    )
    a =  position * tick_angle
    c = :math.cos(a)
    s = :math.sin(a)
    r0 = 0.3 * 100
    cx = 320
    cy = 240
    x = r0 * c + cx
    y = r0 * s + cy
    {x,y}
  end

  """
  this.tick_angle = (2 * Math.PI) / this.num_positions;
  p.position = this.position_of_planet(p, tick_t);
   = (p.speed * tick_t) % this.num_positions

  t = Date.now() / 1000;
  A = p.position * this.tick_angle;
  c = Math.cos(A);
  s = Math.sin(A);
  R0 = p.semimajor_axis * this.radius_factor;
  x = R0 * c + this.cx; // new x coordinates
  y = R0 * s + this.cy; // new y coordinates
  p.x = x;
  p.y = y;
  """
end
