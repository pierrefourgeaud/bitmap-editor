require './lib/utils'

describe Utils do
  
  describe ".is_i?" do

    it { expect(Utils.is_i?("42")).to eq(true) }
    it { expect(Utils.is_i?("FOO")).to eq(false) }

  end

  describe ".is_colour?" do

    it { expect(Utils.is_colour?("B")).to eq(true) }
    it { expect(Utils.is_colour?("b")).to eq(false) }
    it { expect(Utils.is_colour?("FOO")).to eq(false) }

  end

end