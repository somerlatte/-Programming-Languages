(* implemente a função sumLists *)

fun sumLists (beginA::endA, beginB::endB) = beginA + beginB::(sumLists(endA, endB))
| sumLists([], _) = []
| sumLists(_, []) = [];
