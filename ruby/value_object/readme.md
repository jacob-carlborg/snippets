# Value Object Macro

A Value Object is an object defined by its members, not by a unique identity.

A Value Object will have the following defined:

* A constructor taking all members as keyword arguments

* A factory method called `from_entity`, which takes all members as
  positional arguments

* Readers for all of the given members

* A class and instance method called `members` which return an array of the
  names of all members

* Implementation of equality to be defined as: two objects are equal if all
  of their members are equal

## Requirements

* [Ruby](https://ruby-lang.org)

## Usage

1. Copy the snippet and paste it somewhere
1. Call the `value_object` class method from any class:

    ```ruby
    class Coordinate
      value_object :x, :y, :z
    end

    lhs = Coordinate.new(x: 1, y: 2, z: 3)
    rhs = Coordinate.new(x: 1, y: 2, z: 3)
    lhs == rhs # => true

    Coordinate.members # => [:x, :y, :z]
    lhs.members # => [:x, :y, :z]
    ```
