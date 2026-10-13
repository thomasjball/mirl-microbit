import Lake
open Lake DSL

package bounded_map_verification

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib BoundedMap
