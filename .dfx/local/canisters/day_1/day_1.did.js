export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'add' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Nat], []),
    'clear_counter' : IDL.Func([], [], []),
    'days_to_seconds' : IDL.Func([IDL.Nat], [IDL.Nat], []),
    'dividetext' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Text], []),
    'increment_counter' : IDL.Func([IDL.Nat], [IDL.Nat], []),
    'is_even' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'max' : IDL.Func([IDL.Vec(IDL.Nat)], [IDL.Nat], []),
    'square' : IDL.Func([IDL.Nat], [IDL.Nat], []),
    'sum_of_array' : IDL.Func([IDL.Vec(IDL.Nat)], [IDL.Nat], []),
  });
};
export const init = ({ IDL }) => { return []; };
