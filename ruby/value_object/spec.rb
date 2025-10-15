require "spec_helper"

RSpec.describe Module do
  describe "value_object" do
    subject(:cls) { Class.new { value_object :x, :y, :z } }

    context "constructor" do
      it "defines a constructor with keyword arguments for all members" do
        expect(cls.new(x: 1, y: 2, z: 3)).to having_attributes(x: 1, y: 2, z: 3)
      end

      context "when omitting some of the keywords" do
        it "raises error: ArgumentError: missing keywords: z" do
          expect { cls.new(x: 1, y: 2) }
            .to raise_error(ArgumentError, "missing keywords: z")
        end
      end

      context "with additional keywords" do
        it "raises error: ArgumentError: unknown keywords: w" do
          expect { cls.new(x: 1, y: 2, z: 3, w: 4) }
            .to raise_error(ArgumentError, "unknown keywords: w")
        end
      end
    end

    context "from_entity" do
      it "constructs the object from positional arguments" do
        expect(cls.from_entity(1, 2, 3)).to having_attributes(x: 1, y: 2, z: 3)
      end

      context "when the number of arguments and members don't match" do
        it "raises an error" do
          expect { cls.from_entity(1, 2) }.to raise_error(ArgumentError,
            "wrong number of arguments (given 2, expected 3)")
        end
      end
    end

    context "readers" do
      it "defines readers for all members" do
        expect(cls.new(x: 1, y: 2, z: 3)).to having_attributes(x: 1, y: 2, z: 3)
      end
    end

    context "members" do
      context "class method" do
        it "returns the defined members" do
          expect(cls.members).to eq(%i[x y z])
        end
      end

      context "instance method" do
        subject(:object) { cls.new(x: 1, y: 2, z: 3) }

        it "returns the defined members" do
          expect(object.members).to eq(%i[x y z])
        end
      end
    end

    context "equality" do
      specify "two objects are equal when all of their members are equal" do
        lhs = cls.new(x: 1, y: 2, z: 3)
        rhs = cls.new(x: 1, y: 2, z: 3)

        expect(lhs).to eq(rhs)
      end

      specify "two objects are not equal when any of their members are not equal" do
        lhs = cls.new(x: 1, y: 2, z: 3)
        rhs = cls.new(x: 1, y: 4, z: 3)

        expect(lhs).not_to eq(rhs)
      end

      specify "two objects of different types are not equal" do
        expect(cls.new(x: 1, y: 2, z: 3)).not_to eq("foo")
      end
    end
  end
end
