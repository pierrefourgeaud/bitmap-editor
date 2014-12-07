require 'bitmap'

describe Bitmap do

  let(:width)  { 2 }
  let(:height) { 2 }

  subject { Bitmap.new(width, height) }

  describe ".initialize" do

    it { expect(subject.width).to eq(width) }
    it { expect(subject.height).to eq(height) }
    it { expect(subject.data).to eq("O" * width * height) }

  end

  describe "#clear" do

    before do
      subject[0, 0] = 'A'
    end

    it { expect { subject.clear }.to change { subject.data }.from('AOOO').to('OOOO') }

  end

  describe "#[]=" do

    it { expect { subject[0, 0] = 'A' }.to change { subject.data }.from('OOOO').to('AOOO') }

  end

  describe "#[]" do

    before do
      subject[0, 1] = 'A'
    end

    it { expect(subject[0, 1]).to eq('A') }

  end

end