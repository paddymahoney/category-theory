Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Theory.Monad.Algebra.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Unset Transparent Obligations.

Program Definition EilenbergMoore `(T : C ⟶ C) `{@Monad C T} : Category := {|
  ob      := { a : C & TAlgebra T a };
  hom     := fun x y => TAlgebraHom T ``x ``y (projT2 x) (projT2 y);
  homset  := fun _ _ => {| equiv := fun f g => talg_hom[f] ≈ talg_hom[g] |};
  id      := fun _ => {| talg_hom := id |};
  compose := fun _ _ _ f g => {| talg_hom := talg_hom[f] ∘ talg_hom[g] |}
|}.
Next Obligation.
  rewrite fmap_comp.
  rewrite comp_assoc.
  rewrite <- talg_hom_commutes.
  rewrite <- !comp_assoc.
  rewrite <- talg_hom_commutes.
  reflexivity.
Qed.