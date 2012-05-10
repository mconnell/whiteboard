require 'spec_helper'

describe Whiteboard do

  let(:data){ "[{\"fill\":\"none\",\"stroke\":\"#3A3635\",\"path\":\"M141,92L142,92L144,92L150,84L352,82L367,84L395,86L398,89L399,93L399,94\",\"stroke-opacity\":1,\"stroke-width\":5,\"stroke-linecap\":\"round\",\"stroke-linejoin\":\"round\",\"transform\":[],\"type\":\"path\"}]" }

  describe "to_svg" do
    it "returns the whiteboard data as an svg compatable string of paths" do
      whiteboard = Whiteboard.new(:data => data)
      whiteboard.to_svg.should == <<-SVG
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="#{Whiteboard::WIDTH}" height="#{Whiteboard::HEIGHT}" xml:space="preserve">
<desc>Created with Raphael</desc>
<defs></defs>
<path fill="none" stroke="#3A3635" stroke-opacity="1" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" transform="[]" d="M141,92L142,92L144,92L150,84L352,82L367,84L395,86L398,89L399,93L399,94"></path>
</svg>
      SVG
    end
  end

  describe "generate_png_file" do
    it "generates a png file.. duh" do
      whiteboard = Whiteboard.new(:data => data)
      whiteboard.user_id = '123'
      whiteboard.save

      whiteboard.generate_png_file
      whiteboard.png_file_path.should == "/pngs/123_#{whiteboard.id}_#{whiteboard.created_at.to_i}.png"
    end
  end

  describe "deleting a whiteboard" do
    it "removes associated png file, if exists" do
      whiteboard = Whiteboard.new(:data => data)
      whiteboard.user_id = '123'
      whiteboard.save
      whiteboard.generate_png_file

      file_path = Rails.root.join("public#{whiteboard.png_file_path}")
      assert File.exists?(file_path)
      whiteboard.destroy
      assert !File.exists?(file_path)
    end
  end
end
