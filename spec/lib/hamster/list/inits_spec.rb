require "spec_helper"
require "hamster/list"

describe Hamster::List do
  describe "#inits" do
    it "is lazy" do
      -> { Hamster.stream { fail }.inits }.should_not raise_error
    end

    [
      [[], []],
      [["A"], [L["A"]]],
      [%w[A B C], [L["A"], L["A", "B"], L["A", "B", "C"]]],
    ].each do |values, expected|
      context "on #{values.inspect}" do
        let(:list) { Hamster.list(*values) }

        it "preserves the original" do
          list.inits
          list.should eql(Hamster.list(*values))
        end

        it "returns #{expected.inspect}" do
          list.inits.should eql(Hamster.list(*expected))
        end
      end
    end
  end
end