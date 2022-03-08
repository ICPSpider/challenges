import Char "mo:base/Char";
import Chard "mo:base/Char";
import Nat "mo:base/Int";
import Nat8 "mo:base/Nat8";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Int "mo:base/Text";
import Nat32 "mo:base/Nat32";
import Prim "mo:prim";

actor {

    // Challenge 1

    public func nat_to_nat8(n : Nat) : async Nat8 {
        return(Nat8.fromNat(n));
    };

    // Challenge 2
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return ((2 ** n)-1)
    };

    // Challenge 3
    public func decimal_to_bits(n : Nat) : async Text {
        if (n == 0) {
            return "choose another number"
        };
        var tmp: Nat = n;
        var binary: Nat = 0;
        var counter: Nat = 0;
        while (tmp > 0) {
            binary := ((tmp % 2)*(10**counter)) + binary;
            tmp := (tmp/2);
            counter += 1;
        };
            var output = Nat.toText(binary);
            return output;
        };

    // Challenge 4
    public func capitalize_character(t: Text) : async Text {
        return Text.map(t, Prim.charToUpper);
    };

    // Challenge 5
    public func capitalize_text(t: Text) : async Text {
        label letter for (c in t.chars()) {
            Debug.print(debug_show(c));
        }; return Text.map(t, Prim.charToUpper);
    };

    // Challenge 6

    public func is_inside (t : Text, c: Text) :async Bool{
    var counter = 0;
    for (char in t.chars()){
      for (char2 in c.chars()){
        if  (char == char2) {
          counter +=1;
        };
      };
    };
    return counter >= 1;
  };

}