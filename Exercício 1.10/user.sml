(* implemente a função planetAge *)

datatype Planeta  = Mercurio | Venus | Terra | Marte | Jupiter | Saturno | Urano | Netuno;

fun planetAge (meses, (Mercurio)) = meses div 12 * 88
  | planetAge (meses, Venus) = meses div 12 * 225
  | planetAge (meses, (Terra)) = meses div 12 * 365
  | planetAge (meses, (Marte)) = meses div 12 * 687
  | planetAge (meses, Jupiter) = meses div 12 * 4332
  | planetAge (meses, Saturno) = meses div 12 * 10760
  | planetAge (meses, Urano) = meses div 12 * 30681
  | planetAge (meses, Netuno) = meses div 12 * 60190;

planetAge(24, Jupiter);