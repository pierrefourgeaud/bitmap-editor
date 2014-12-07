require 'rspec/its'
require 'bitmap'

describe Bitmap do

  describe "#initialize" do

    let(:width) { 2 }
    let(:height) { 3 }

    subject { Bitmap.new(width, height) }

    its(:width)  { should eq(width) }
    its(:height) { should eq(height) }
    its(:data)   { should eq("O" * width * height) }

  end

end