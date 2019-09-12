
defmodule LiveViewDemoWeb.PlanetsLive do
  use Phoenix.LiveView
  # import Calendar.Strftime
  import Planets

  def render(assigns) do
    ~L"""
    <div>
    <svg
    viewBox="0 0 <%= @width %> <%= @height %>"
    xmlns="http://www.w3.org/2000/svg"
    stroke="<%= @stroke %>"
    fill="<%= @fill %>">
        <%= for {name,px,py,r} <- @planets do %>
          <circle
          id="<%= r %>"
          phx-click="choose" 
          phx-value="<%= name %>"
          cx="<%= px %>" 
          cy="<%= py %>" 
          r="<%= r %>" >
          </circle>
        <% end %>
      </svg>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_svg(socket) |> put_planets }
  end

  def handle_event("choose", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_svg(socket) |> put_planets }
  end

  defp put_svg(socket) do
    assign(socket, width: MySVG.width, height: MySVG.height, stroke: "cyan", fill: "blue" )
  end

  defp put_planets(socket) do
    assign(socket, planets: planets() )
  end

  defp planets do
    Enum.map(Planets.list, fn(p) -> position_of_planet(p) end )
  end

  defp position_of_planet(planet) do
    num_positions = 576
    radius_factor = (MySVG.height / 2) * 16;

    # what "o'clock" are we
    tick_angle = ( :math.pi * 2 )  / num_positions
    # unix time current second modulo how many ticks are on our "clock"
    position = rem(
      Calendar.DateTime.Format.unix(
        Calendar.DateTime.now!("UTC")
      ) * planet.speed,
        num_positions
    )
    a =  position * tick_angle
    c = :math.cos(a)
    s = :math.sin(a)
    r0 = planet.semimajor_axis * radius_factor # how far out from center
    # center of the svg
    cx = MySVG.width / 2
    cy = MySVG.height /2
    x = r0 * c + cx
    y = r0 * s + cy
    {planet.name,x,y,planet.radius*9} # NOTE 9 is a magic number for some reason
  end
end

defmodule MySVG do
  def width do
    800
  end

  def height do
    600
  end
end
