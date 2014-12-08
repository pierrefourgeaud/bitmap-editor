require 'app'

describe App do

  subject { App.new }

  describe ".initialize" do

    it { expect(subject.bitmap).to eq(nil) }
    it { expect(subject.parser).to be_a(Parser) }

  end

end