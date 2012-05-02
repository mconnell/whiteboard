require 'spec_helper'

describe Drawing do

  let(:data){ "[{\"fill\":\"none\",\"stroke\":\"#3A3635\",\"path\":\"M141,92L142,92L144,92L150,84L352,82L367,84L395,86L398,89L399,93L399,94\",\"stroke-opacity\":1,\"stroke-width\":5,\"stroke-linecap\":\"round\",\"stroke-linejoin\":\"round\",\"transform\":[],\"type\":\"path\"}]" }

  describe "to_svg" do
    it "returns the drawing data as an svg compatable string of paths" do
      drawing = Drawing.new(:data => data)
      drawing.to_svg.should == <<-SVG
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="#{Drawing::WIDTH}" height="#{Drawing::HEIGHT}" xml:space="preserve">
<desc>Created with Raphael</desc>
<defs></defs>
<path fill="none" stroke="#3A3635" stroke-opacity="1" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" transform="[]" d="M141,92L142,92L144,92L150,84L352,82L367,84L395,86L398,89L399,93L399,94"></path>
</svg>
      SVG
    end
  end

  describe "generate_png_file" do
    it "generates a png file.. duh" do
      drawing = Drawing.new(:data => data)
      drawing.user_id = '123'
      drawing.save

      drawing.generate_png_file
      drawing.png_file_path.should == "/pngs/123_#{drawing.id}_#{drawing.created_at.to_i}.png"
    end
  end

  describe "deleting a drawing" do
    it "removes associated png file, if exists" do
      drawing = Drawing.new(:data => data)
      drawing.user_id = '123'
      drawing.save
      drawing.generate_png_file

      file_path = Rails.root.join("public#{drawing.png_file_path}")
      assert File.exists?(file_path)
      drawing.destroy
      assert !File.exists?(file_path)
    end
  end
end
