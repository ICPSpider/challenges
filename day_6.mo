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

// Challenge 1 : Create an actor in main.mo and declare the following types.
// TokenIndex of type Nat.
// Error which is a variant type with multiples tags :

type TokenIndex = Nat;
    type Error = {
        #DefaultError;
        #UserError;
    };

// Challenge 2 : Declare an HashMap called registry with Key of type TokenIndex and value of type Principal. This will keeep track of which 
// principal owns which TokenIndex.

stable var registryEntry : [(TokenIndex, Principal)] = [];
    let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.fromIter<TokenIndex, Principal>(registryEntry.vals(), 0, Nat.equal, Hash.hash);

// Challenge 3 : Declare a variable of type Nat called nextTokenIndex, initialized at 0 that will keep track of the number of minted NFTs.
// Write a function called mint that takes no argument.
// This function should :
// Returns a result of type Result and indicate an error in case the caller is anonymous.
// If the user is authenticated : associate the current TokenIndex with the caller (use the HashMap we've created) and increase nextTokenIndex.

var nextTokenIndex : Nat = 0;
    public shared({ caller }) func mint() : async Result.Result<(), Error> {
        if (caller == Principal.fromText("2vxsx-fae")) return #err(#UserError);
        registry.put(nextTokenIndex, caller);
        nextTokenIndex += 1;
        lastMinter := caller;
        return #ok;
    };

// Challenge 4 : Write a function called transfer that takes two arguments :
// to of type Principal.
// tokenIndex of type Nat.
// This function will transfer ownership of tokenIndex to the specified principal. You will check for eventuals errors and 
// returns a result of type Result.

public shared({ caller }) func transfer(to: Principal, tokenIndex: Nat) : async Result.Result<(), Error> {
        let owner: ?Principal = registry.get(tokenIndex);
        switch(owner) {
            case(null) return #err(#UserError);
            case(?principal) {
                if (principal != caller) return #err(#UserError);
            };
        };
        // transfer the token
        registry.put(tokenIndex, to);
        // update the balances
        #ok;
    };

// Challenge 5 : Write a function called balance that takes no arguments but returns a list of tokenIndex owned by the called.

public shared({ caller }) func balance() : async [TokenIndex] {
        Iter.toArray(HashMap.mapFilter<TokenIndex, Principal, Principal>(
            registry, 
            Nat.equal, 
            Hash.hash, 
            func(key : TokenIndex, val : Principal) {
                if(val == caller) {
                    return ?val;
                };
                return null;
                }).keys());
    };

    var lastMinter : Principal = Principal.fromText("2vxsx-fae");

// Challenge 6 : Write a function called http_request that should return a message indicating the number of nft minted so far 
// and the principal of the latest minter. (Use the section on http request in the daily guide).


// Challenge 7 : Modify the actor so that you can safely upgrade it without loosing any state.

system func preupgrade() {
        registryEntry := Iter.toArray<(TokenIndex, Principal)>(registry.entries());
    };

    system func postupgrade() {
        registryEntry := [];
    };

// Well... you've just created your own NFT standard 🔥.

// Bonus : intercanister calls.


// Challenge 8 : Create another canister and use to mint a NFT by calling the mint method of your first canister.
// Well... you just created your own on-chain wallet. 🔒

// Bonus optional (Only take on those challenges if you have nothing else to do today...)

// Ledger canister 💰

// Challenge 9 : In a new actor implement a function called default_account that returns the address of the subbacount 0 for the canister.

// Challenge 10 : Write two functions :

// balance : takes no arguments and returns the balance of icps of the canister defaul account.
// transfer : takes
// Ressources for challenge 9 & 10.

// Lectures on the ledger canister :
// Example of icp in canister :

}