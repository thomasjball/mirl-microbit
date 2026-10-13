# boundedMap proof

This Lean 4 project proves properties of the exact-rational model of
`Math.boundedMap` in `../helpers.ts`.

From the repository root, after installing the pinned Lean toolchain with
elan, run:

```sh
cd verification
lake update
lake exe cache get
lake build
```

The proofs establish that clamping stays within the input interval, both input
endpoints map to their corresponding output endpoints (when the input range is
non-degenerate), and every result lies within the output interval regardless
of endpoint order. A degenerate input interval returns `out1`, matching the
TypeScript implementation.

The proof models arithmetic over exact rationals. It establishes the
mathematical behavior of the formula, not IEEE-754 rounding or JavaScript
`NaN`/infinity behavior.
