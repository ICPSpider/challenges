import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Char "mo:base/Char";

actor {

    // Challenge 1
    public func add(n : Nat, m : Nat) : async Nat {
        return(n + m);
    };

    // Challenge 2
    public func square(n : Nat) : async Nat {
        return(n * n);
    };

    // Challenge 3
    public func days_to_seconds(n : Nat) : async Nat {
        return(n * 24 * 60 * 60); // Each day has 24 hours; each hour has 60 minutes; each minute has 60 seconds.
    };

    // Challenge 4

    // Create a mutable variable
    var counter : Nat = 0;

    public func increment_counter(n : Nat) : async Nat {
        counter += n;
        return(counter);
    };

    public func clear_counter() : async () {
        counter := 0;
        return counter;
    };

    // Challenge 5

    public func divide(n : Nat, m : Nat) : async Bool {
        if(n % m == 0) {
            return true;
        } else {
            return false;
        }

    };

    // Challenge 6
    public func is_even(n: Nat) : async Bool {
        if (n % 2 == 0) {
            return(true);
        } else {
            return(false);
        }
    };

    // Challenge 7
    let array : [Nat] = [9, 18, 27, 36];
    public func sum_of_array(a : [Nat]) : async Nat {
        var counter = 0;
        for(value in a.vals()) {
            counter := value + counter;
        };
        return(counter)
    };

    // Challenge 8
    public func max(a : [Nat]) : async Nat {
        var n : Nat = 0;
        for(value in a.vals()) {
            if (n < value) {
                n := value
            };
        };
        return (n);
    };

};