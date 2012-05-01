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
end
