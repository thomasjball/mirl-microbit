module

import Mathlib

def clampToRange (value in1 in2 : ℚ) : ℚ :=
  min (max value (min in1 in2)) (max in1 in2)

def boundedMap (value in1 in2 out1 out2 : ℚ) : ℚ :=
  if in1 = in2 then out1
  else
    ((clampToRange value in1 in2 - in1) * (out2 - out1)) /
      (in2 - in1) + out1

theorem clampToRange_ge_min (value in1 in2 : ℚ) :
    min in1 in2 ≤ clampToRange value in1 in2 := by
  unfold clampToRange
  exact le_min (le_max_right _ _) min_le_max

theorem clampToRange_le_max (value in1 in2 : ℚ) :
    clampToRange value in1 in2 ≤ max in1 in2 := by
  unfold clampToRange
  exact min_le_right _ _

theorem clampToRange_at_in1 (in1 in2 : ℚ) :
    clampToRange in1 in1 in2 = in1 := by
  unfold clampToRange
  rcases le_total in1 in2 with h | h
  · simp [min_eq_left h, max_eq_right h]
  · simp [min_eq_right h, max_eq_left h]

theorem clampToRange_at_in2 (in1 in2 : ℚ) :
    clampToRange in2 in1 in2 = in2 := by
  unfold clampToRange
  rcases le_total in1 in2 with h | h
  · simp [min_eq_left h, max_eq_right h]
  · simp [min_eq_right h, max_eq_left h, min_eq_left h]

theorem boundedMap_at_in1 (in1 in2 out1 out2 : ℚ) (h : in1 ≠ in2) :
    boundedMap in1 in1 in2 out1 out2 = out1 := by
  simp [boundedMap, h, clampToRange_at_in1]

theorem boundedMap_at_in2 (in1 in2 out1 out2 : ℚ) (h : in1 ≠ in2) :
    boundedMap in2 in1 in2 out1 out2 = out2 := by
  have hden : in2 - in1 ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  simp [boundedMap, h, clampToRange_at_in2]
  field_simp
  ring

theorem boundedMap_within_output_range (value in1 in2 out1 out2 : ℚ) :
    min out1 out2 ≤ boundedMap value in1 in2 out1 out2 ∧
      boundedMap value in1 in2 out1 out2 ≤ max out1 out2 := by
  by_cases h : in1 = in2
  · simp [boundedMap, h]
  · have hden : in2 - in1 ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
    let x := clampToRange value in1 in2
    let t := (x - in1) / (in2 - in1)
    have hxlo := clampToRange_ge_min value in1 in2
    have hxhi := clampToRange_le_max value in1 in2
    have htlo : 0 ≤ t := by
      rcases lt_or_gt_of_ne h with horder | horder
      · have hlo := hxlo
        rw [min_eq_left (le_of_lt horder)] at hlo
        dsimp [t, x]
        apply div_nonneg
        · linarith
        · linarith
      · have hhi := hxhi
        rw [max_eq_left (le_of_lt horder)] at hhi
        dsimp [t, x]
        exact div_nonneg_of_nonpos (by linarith) (by linarith)
    have hthi : t ≤ 1 := by
      rcases lt_or_gt_of_ne h with horder | horder
      · have hlo := hxlo
        have hhi := hxhi
        rw [min_eq_left (le_of_lt horder)] at hlo
        rw [max_eq_right (le_of_lt horder)] at hhi
        dsimp [t, x]
        rw [div_le_one (by linarith : 0 < in2 - in1)]
        linarith
      · have hlo := hxlo
        rw [min_eq_right (le_of_lt horder)] at hlo
        dsimp [t, x]
        rw [div_le_one_of_neg (by linarith : in2 - in1 < 0)]
        linarith
    have hformula :
        boundedMap value in1 in2 out1 out2 =
          (1 - t) * out1 + t * out2 := by
      unfold boundedMap
      simp [h]
      dsimp [t, x]
      ring
    rw [hformula]
    have h1lo : min out1 out2 ≤ out1 := min_le_left _ _
    have h2lo : min out1 out2 ≤ out2 := min_le_right _ _
    have h1hi : out1 ≤ max out1 out2 := le_max_left _ _
    have h2hi : out2 ≤ max out1 out2 := le_max_right _ _
    constructor
    · nlinarith [mul_nonneg (show 0 ≤ 1 - t by linarith) (show 0 ≤ out1 - min out1 out2 by linarith),
        mul_nonneg htlo (show 0 ≤ out2 - min out1 out2 by linarith)]
    · nlinarith [mul_nonneg (show 0 ≤ 1 - t by linarith) (show 0 ≤ max out1 out2 - out1 by linarith),
        mul_nonneg htlo (show 0 ≤ max out1 out2 - out2 by linarith)]
