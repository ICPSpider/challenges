import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'add' : (arg_0: bigint, arg_1: bigint) => Promise<bigint>,
  'clear_counter' : () => Promise<undefined>,
  'days_to_seconds' : (arg_0: bigint) => Promise<bigint>,
  'dividetext' : (arg_0: bigint, arg_1: bigint) => Promise<string>,
  'increment_counter' : (arg_0: bigint) => Promise<bigint>,
  'is_even' : (arg_0: bigint) => Promise<boolean>,
  'max' : (arg_0: Array<bigint>) => Promise<bigint>,
  'square' : (arg_0: bigint) => Promise<bigint>,
  'sum_of_array' : (arg_0: Array<bigint>) => Promise<bigint>,
}
