import VersoSlides

open VersoSlides

#doc (Slides) "A Tiny Verified Traffic Light" =>

# Model the states

A traffic light has a small, fixed set of possible states. An inductive type makes that set explicit.

```lean
inductive Light where
  | red
  | green
  | yellow
  deriving Repr, BEq
```

# Define the transition

Pattern matching makes the behavior exhaustive: every state has a next state.

```lean
def next : Light → Light
  | .red => .green
  | .green => .yellow
  | .yellow => .red
```

:::fragment
For example, {lean}`next Light.red` is {lean}`Light.green`.
:::

# Run the model

Lean can execute the same definition used in the presentation.

```lean
#eval next .red
```

# State a property

This behavior can also be stated as a proposition and checked by Lean.

```lean
theorem red_changes_to_green : next .red = .green := by
  rfl
```

The proof closes by computation: both sides reduce to the same constructor.

# The useful habit

:::fragment
Make states explicit.
:::

:::fragment
Define behavior by cases.
:::

:::fragment
Turn important expectations into checked propositions.
:::

# Questions

What property would you prove next?
