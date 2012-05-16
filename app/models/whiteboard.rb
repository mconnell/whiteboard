class Whiteboard < ActiveRecord::Base
  attr_accessible :data

  belongs_to :user

  after_save :generate_png_file
  before_destroy :remove_png_file

  WIDTH  = 938
  HEIGHT = 550

  def to_svg
    svg = [
      "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" width=\"#{Whiteboard::WIDTH}\" height=\"#{Whiteboard::HEIGHT}\" xml:space=\"preserve\">",
      "<desc>Created with Raphael</desc>",
      "<defs></defs>",
      data_to_svg_paths,
      "</svg>\n",
    ].join("\n")
  end

  def generate_png_file
    file_name = "#{user_id}_#{id}_#{created_at.to_i}"
    temp_file = File.new("/tmp/#{file_name}.svg", 'w')
    temp_file.write(self.to_svg)
    temp_file.close
    `convert #{temp_file.path} -resize 298x175 #{Rails.root.join("public", "pngs", "#{file_name}.png")}`
    File.delete(temp_file)
    update_column :png_file_path, "/pngs/#{file_name}.png"
  end
  handle_asynchronously :generate_png_file

  def data_to_svg_paths
    paths = JSON.parse(data)
    paths.map do |path|
      path.delete('type')
      path['d'] = path.delete('path')
      "<path #{path.map { |attr, value| "#{attr}=\"#{value}\"" }.join(" ") }></path>"
    end.join("\n")
  end

  def remove_png_file
    File.delete Rails.root.join("public#{png_file_path}")
  end
  handle_asynchronously :remove_png_file

end
