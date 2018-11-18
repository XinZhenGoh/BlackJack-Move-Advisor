(defrule p1
?p <-(start); ?p var p
=>
(printout t "Would you like Seafood for the dinner ?")
(assert (seafood (read)))
(retract ?p)) ; input p for user


;COMMENT: seafood recomendationdation 

(defrule p2
(seafood yes)
=>
(printout t "Would you like Rawfish ?")
(assert (Rawfish(read))))

(defrule p3
(Rawfish yes)
=>
(printout t "Would you like Shellfish ?")
(assert (Shellfish(read))))

(defrule pair1
(Shellfish yes)
=>
(printout t "Sauvignon Blanc is one of the most popular white wines" crlf))

(defrule pair2
(Shellfish no)
=>
(printout t "Muscadet and Albariño are loved as an excellent raw seafood Albariño wine " crlf))

(defrule p4
(Rawfish no)
=>
(printout t "Would you like Asian seafood or anything spicy ?")
(assert (Spicy(read))))

(defrule pair3
(Spicy yes)
=>
(printout t "the tropical aromas of Roussanne and Marsanne, which are Rhone white varietals, marry perfectly with the flavors of Asia." crlf))

(defrule pair4
(Rawfish no)
(Spicy no)
=>
(printout t "Looking for something off the beaten track that fits this style? Try an Italian vermentino or a Greek assyrtiko." crlf))

;COMMENT STEAK 

 
 (defrule pp1
 (seafood no)
 =>
 (printout t "is the steak lean cut?")
 (assert (cut(read))))
 
 (defrule pp2
 (cut yes)
 =>
 (printout t "Barolo or a Napa Cabernet would work well" crlf))
 
 (defrule pp3
 (cut no)
 =>
 (printout t "Is it prime ribs?")
 (assert (Pribs(read))))
 
 (defrule pp4
 (Pribs yes)
 =>
 (printout t "Choose a Bordeaux from France or a Merlot that hasnt been aged very long" crlf))
 
 
(defrule pp5
(Pribs no)
=>
(printout t "Go with a big Burgundy from France or a Zinfandel from Sonoma, California" crlf))

(deffacts startup
 (start))