(* step through the proof one step at a time. the proof state will often not update. there is nothing unusual about this proof.
 any other proof suffers from the same problem. there is no problem when using coqtop-hang as coqtop *)

Require Import NArith.
Open Scope N_scope.
Import N.
Lemma log2_spec n : 0 < n ->
 2^(log2 n) <= n < 2^(succ (log2 n)).
Proof.
 destruct n as [|[p|p|]]; discriminate || intros _; simpl; split.
 - apply (size_le (pos p)).
 - apply Pos.size_gt.
 - apply Pos.size_le.
 - apply Pos.size_gt.
 - discriminate.
 - reflexivity.
Qed.
