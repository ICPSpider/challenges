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
import Bool "mo:base/Bool";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";
import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor {

//Challenge 1 : Write a function is_anonymous that takes no arguments but returns true is the caller is anonymous and false otherwise.

    public shared({caller}) func is_anonymous() : async Bool {
        caller == Principal.fromText("2vxsx-fae");
    };

//Challenge 2 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    favoriteNumber.put(anonymous_principal, 1);

    public func test(): async ?Nat {
        return(favoriteNumber.get(Principal.fromText("2vxsx-fae")));
    };

/*Challenge 3 : Write two functions :
add_favorite_number that takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller. 
This function has no return value.
show_favorite_number that takes no argument and returns n of type ?Nat, n is the favorite number of the person as defined in the 
previous function or null if the person hasn't registered.*/

    
    public func add_favorite_number(n: Nat) : () {
        favoriteNumber.put(anonymous_principal, n);
    };

    public func show_favorite_number() : async ?Nat {
        return (favoriteNumber.get(anonymous_principal));
    };


/*Challenge 4 : Rewrite your function add_favorite_number so that if the caller has already registered his favorite number, the value 
in memory isn't modified. This function will return a text of type Text that indicates "You've already registered your number" in that 
case and "You've successfully registered your number" in the other scenario.*/
    
    public shared({ caller }) func add_favorite_number1(n: Nat) : async Text {
        switch(favoriteNumber.get(caller)) {
            case null {
                favoriteNumber.put(caller, n);
                return "You've successfully registered your number";
            };
            case (?nat) return "You've already registered your number";
        };
    };


/*Challenge 5 : Write two functions
update_favorite_number
delete_favorite_number*/

public shared({ caller }) func update_favorite_number(n : Nat) : () {
        favoriteNumber.put(caller, n);
    };

    public shared({ caller }) func delete_favorite_number() : () {
        favoriteNumber.delete(caller);
    };

/*Challenge 6 : Write a function deposit_cycles that allow anyone to deposit cycles into the canister. This function takes no parameter 
but returns n of type Nat corresponding to the amount of cycles deposited by the call.*/

public func deposit_cycles() : async Nat {
        let available = Cycles.available();
        let accepted = Cycles.accept(available);
        assert(available == accepted);
        accepted;
    };

/*Challenge 7 (hard ⚠️) : Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the number of cycles 
you want to withdraw from the canister and send it to caller asumming the caller has a callback called deposit_cycles()
Note : You need two canisters.
Note 2 : Don't do that in production without admin protection or your might be the target of a cycle draining attack.*/


/*Challenge 8 : Rewrite the counter (of day 1) but this time the counter will be kept accross ugprades. Also declare a variable of type 
**Nat¨¨ called version_number that will keep track of how many times your canister has been upgraded.*/

    stable var counter : Nat = 0;
    stable var version_number : Nat = 0;
    public func increment_counter(n:Nat) : async Nat {
        counter+= n;
        return (counter);
    };

    public func clear_counter() {
        counter := 0;
    };

    public func version() : async Nat {
        return (version_number);
    };

    system func preupgrade() {
        
    };

    system func postupgrade() {
        version_number+= 1;
    };


/*Challenge 9 : In a new file, copy and paste the functionnalities you've created in challenges 2 to 5. This time the hashmap and all 
records should be preserved accross upgrades.*/


/*Challenge 10 (optionale) : In autonomy, write a CRUD canister, you can add as much functionnalities as you want, a few examples :
Anonymous principal rejection.
Cycle functionnality for registration.
Admin management.
Note : Only practice challenge 10 if you wish to, this is optional and it will not be taken into account for any ranking.*/

}