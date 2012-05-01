class Drawing < ActiveRecord::Base
  attr_accessible :data

  belongs_to :user

  WIDTH  = 938
  HEIGHT = 400

  def to_svg
    svg = [
      "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" width=\"#{Drawing::WIDTH}\" height=\"#{Drawing::HEIGHT}\" xml:space=\"preserve\">",
      "<desc>Created with Raphael</desc>",
      "<defs></defs>",
      data_to_svg_paths,
      "</svg>\n",
    ].join("\n")
  end

  private
  def data_to_svg_paths
    paths = JSON.parse(data)
    paths.map do |path|
      path.delete('type')
      path['d'] = path.delete('path')
      "<path #{path.map { |attr, value| "#{attr}=\"#{value}\"" }.join(" ") }></path>"
    end.join("\n")
  end
end
