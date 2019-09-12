defmodule Planets do
  def list do
    [
      # { name: "A", speed: 0, radius: 0.00000001 },
      %{ name: "B", speed: 24, semimajor_axis: 0.01154775, radius: 1.121 },
      %{ name: "C", speed: 15, semimajor_axis: 0.01581512, radius: 1.095 },
      %{ name: "D", speed: 9, semimajor_axis: 0.02228038, radius: 0.784 },
      %{ name: "E", speed: 6, semimajor_axis: 0.02928285, radius: 0.910 },
      %{ name: "F", speed: 4, semimajor_axis: 0.03853361, radius: 1.046 },
      %{ name: "G", speed: 3, semimajor_axis: 0.04687692, radius: 1.148 },
      %{ name: "H", speed: 2, semimajor_axis: 0.06193488, radius: 0.773 }
    ]
  end

  """
  this.planets = [
    // { name: "A", speed: 0, radius: 0.00000001 },
    { name: "B", speed: 24, semimajor_axis: 0.01154775, radius: 1.121 },
    { name: "C", speed: 15, semimajor_axis: 0.01581512, radius: 1.095 },
    { name: "D", speed: 9, semimajor_axis: 0.02228038, radius: 0.784 },
    { name: "E", speed: 6, semimajor_axis: 0.02928285, radius: 0.910 },
    { name: "F", speed: 4, semimajor_axis: 0.03853361, radius: 1.046 },
    { name: "G", speed: 3, semimajor_axis: 0.04687692, radius: 1.148 },
    { name: "H", speed: 2, semimajor_axis: 0.06193488, radius: 0.773 }
  ];

  """
end
