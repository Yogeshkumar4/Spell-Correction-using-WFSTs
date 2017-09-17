# Spell-Correction-using-WFSTs

In this work we have used WFSTs to do spell correction. Finite state acceptors are already placed in dev_wrd directory. You can run evaluate.sh to check the results.
We edit the strings in three different ways-
1. E_basic.fst -> Simply produces all strings with edit distance = 1
2. E_dup.fst -> In addition to edit distance = 1, it also allows transition such as xx -> x or x -> xx with cost 1/2 each.
3. E_Swap.fst -> In addition to edit distance = 1, it also allows swapping of letters.
