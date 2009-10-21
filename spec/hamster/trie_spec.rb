require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Hamster

  describe Trie do
  
    before do
      @expected_pairs = {}
      @trie = Trie.new

      ("A".."Z").each do |letter|
        @expected_pairs.store(letter, letter.downcase)
        @trie.store(letter, letter.downcase)
      end
    end
    
    it "is Enumerable" do
      Trie.is_a?(Enumerable)
    end

    describe "#each" do
        
      before do
        @actual_pairs = {}
      end
      
      describe "internal iteration" do

        it "returns all key value pairs" do
          @trie.each do |key, value|
            @actual_pairs[key] = value
          end
        end

      end

      describe "external iteration" do

        it "returns all key value pairs" do
          enum = @trie.to_enum
          loop do
            key, value = enum.next
            @actual_pairs[key] = value
          end
        end

      end
      
      after do
        @actual_pairs.should == @expected_pairs
      end

    end

    describe "#[]" do

      it "returns values associated with existing keys" do
        ("A".."Z").each do |letter|
          @trie[letter].should == letter.downcase
        end
      end
    
      it "returns nil for non-existing" do
        @trie["missing"].should be_nil
      end
    
    end
  
    describe "#has_key?" do

      it "returns true with existing keys" do
        ("A".."Z").each do |letter|
          @trie.has_key?(letter).should be_true
        end
      end
    
      it "returns false for non-existing" do
          @trie.has_key?("missing").should be_false
      end

    end
  
    describe "#store" do
    
      describe "with keys that already exist" do

        it "returns the previous value" do
          @trie.store("A", "Aye").should == "a"
        end

        it "replaces the previous value" do
          @trie.store("A", "Aye")
          @trie["A"].should == "Aye"
        end
      
        it "leaves size unchanged" do
          @trie.size.should == 26
        end
      
      end
    
      describe "with keys that don't exist"
    
        it "returns nil" do
          @trie.store("missing", "in action").should be_nil
        end
    
        it "sets the value" do
          @trie.store("missing", "in action")
          @trie["missing"].should == "in action"
        end
      
        it "increases size by 1" do
          @trie.store("missing", "in action")
          @trie.size.should == 27
        end

    end

  end

end
