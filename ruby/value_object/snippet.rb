class Module
  # Defines the receiver to be a value object.
  #
  # A Value Object is defined by its members, not by a unique identity.
  #
  # A Value Object will have the following defined:
  #
  # * A constructor taking all members as keyword arguments
  #
  # * A factory method called `from_entity`, which takes all members as
  #   positional arguments
  #
  # * Readers for all of the given members
  #
  # * A class and instance method called `members` which return an array of the
  #   names of all members
  #
  # * Implementation of equality to be defined as: two objects are equal if all
  #   of their members are equal
  #
  # @example
  #   class Coordinate
  #     value_object :x, :y, :z
  #   end
  #
  #   Coordinate.new(x: 1, y: 2, z: 3)
  #
  #   Coordinate.from_entity(1, 2, 3)
  #
  #   Coordinate.members # => [:x, :y, :z]
  #   Coordinate.new(x: 1, y: 2, z: 3).members # => [:x, :y, :z]
  #
  #   c = Coordinate.new(x: 1, y: 2, z: 3)
  #   c.x # => 1
  #   c.y # => 2
  #   c.z # => 3
  #
  #   lhs = Coordinate.new(x: 1, y: 2, z: 3)
  #   rhs = Coordinate.new(x: 1, y: 2, z: 3)
  #   lhs == rhs # => true
  #
  # @param members [Array<Symbol>] the members to define
  def value_object(*members)
    instance_eval { attr_reader *members }
    define_singleton_method(:members) { members }

    module_eval do
      def members = self.class.members

      def initialize(**kwargs)
        missing = members - kwargs.keys
        extra = kwargs.keys - members

        raise ArgumentError.new("missing keywords: #{missing.join(', ')}") if missing.any?
        raise ArgumentError.new("unknown keywords: #{extra.join(', ')}") if extra.any?

        members.each { instance_variable_set("@#{_1}", kwargs[_1]) }
      end

      def self.from_entity(*args)
        given = args.length
        expected = members.length
        raise ArgumentError, "wrong number of arguments (given #{given}, expected #{expected})" if given != expected

        new(**members.map.with_index { [_1, args[_2]] }.to_h)
      end

      def ==(other)
        return false unless other.is_a?(self.class)
        !!members.each { public_send(_1) == other.public_send(_1) or return false }
      end
    end
  end
end
