;;Son Le & Ray 
;; Fuzzy Set definition
;; 5 decks * 5(10JQKA*4) = 100, so range will be from[-50 to 50] cards
(deftemplate 10JQKA
 0 100 cards
 ( (Neg (25 1) (50 0))
 (Zer (25 0) (50 1) (75 0))
 (Pos (50 0) (75 1))))
 
;; Will be 5 decks, estimate to see how many decks left in the table 
;; range will be from [-2.5 to 2.5] 
(deftemplate DecksCount
 1 5 deck
 ( (Neg (2 1) (3 0))
 (Zer (2 0) (3 1) (4 0))
 (Pos (3 0) (4 1))))
 
(deftemplate Act
 0 100 decision
 ( (BN (0 1) (25 0))
 (N (0 0) (25 1) (50 0))
 (Z (25 0) (50 1) (75 0))
 (P (50 0) (75 1) (100 0))
 (BP (75 0) (100 1))))
 
 ;*************************************************

(defrule p1
?p <-(start); ?p var p	
=>
(printout t " What is the total count value of both cards in your hand?")
(assert (player_card (read)))
(retract ?p)
(printout t " What is the dealer's face up card value ?")
(assert (dealer_card (read)))
(retract ?p)
); input from dealer and player

;////////////////////////////////////////////////////

(defrule choice1
(player_card 17|18|19|20) ; These are the & (and), | (or), and ~ (not) connective constraints
=>
(printout t "STAND" crlf))

(defrule choice2
(player_card 16)
(dealer_card 2|3|4|5|6)
?i <- (initial-fact)
=>
(printout t "Could you roughly estimate how many high cards (10-J-Q-K) have you seen
otherwise enter NO : ")
		(bind ?response (read))
	(assert (Highcard ?response))
	(printout t "Could you estimate how many deck of cards are left to be dealt? : ")
	(bind ?response (read))
	(assert (DecksLeft ?response))
	(retract ?i))


 ;;using fuzzy logic when player has 12-16
 ;;and Dealer has 2-16 (upcard)
(defrule choice3
(player_card 16)
(dealer_card 7|8|9)
=>
(printout t "HIT error here" crlf))

;; fuzzify the inputs
(defrule fuzzify
 (Highcard ?a)
 (DecksLeft ?d)
 =>
 (assert (10JQKA (?a 0) (?a 1) (?a 0)))
 (assert (DecksCount (?d 0) (?d 1) (?d 0)))
 )
 ;; defuzzify the outputs
(defrule defuzzify1
 (declare (salience -1))
 ?f <- (Act ?)
 =>
 (bind ?t (moment-defuzzify ?f))
 (if(>= ?t 75)
 then
 (printout t "Your chance of winning is " ?t " % it favors you to HIT" crlf)
 else
 (printout t "You should STAND, chances of winning is " ?t"% " crlf)))


(defrule choice4
(player_card 16)
(dealer_card 10|A)
=>
(printout t "SURRENDER" crlf))

(defrule choice5
(player_card 12|13|14|15)
(dealer_card 7|8|9|10|A)
=>
(printout t "HIT " crlf))

(defrule choice6
(player_card 12|13|14|15)
(dealer_card 2|3|4|5|6)
?i <- (initial-fact)
=>
(printout t "Could you roughly estimate how many high cards (10-J-Q-K) have you seen
otherwise enter NO : ")
		(bind ?response (read))
	(assert (Highcard ?response))
	(printout t "Could you estimate how many deck of cards are left to be dealt? : ")
	(bind ?response (read))
	(assert (DecksLeft ?response))
	(retract ?i))

(defrule choice7
(player_card 11)
=>
(printout t "DOUBLE DOWN" crlf))

(defrule choice8
(player_card 10)
(dealer_card 10|A)
=>
(printout t "HIT" crlf))

(defrule choice9
(player_card 10)
(dealer_card 2|3|4|5|6|7|8|9)
=>
(printout t "DOUBLE DOWN" crlf))

(defrule choice10
(player_card 9)
(dealer_card 7|8|9|10|A)
=>
(printout t "HIT" crlf))

(defrule choice11
(player_card 9)
(dealer_card 2|3|4|5|6)
=>
(printout t "DOUBLE DOWN" crlf))

(defrule choice12
(player_card 8)
(dealer_card 5|6)
=>
(printout t "DOUBLE DOWN" crlf))

(defrule choice13
(player_card 8)
(dealer_card 2|3|4|7|8|9|10|A)
=>
(printout t "HIT" crlf))

(defrule choice14
(player_card 2|3|4|5|6|7)
=>
(printout t "HIT" crlf))



;*********************************************************


;; FAM rule definition
(defrule PP
 (10JQKA Pos)
 (DecksCount Pos)
 =>
 (assert (Act BP)))
(defrule PZ
 (10JQKA Pos)
 (DecksCount Zer)
 =>
 (assert (Act P)))
(defrule PN
 (10JQKA Pos)
 (DecksCount Neg)
 =>
 (assert (Act Z)))
(defrule ZP
 (10JQKA Zer)
 (DecksCount Pos)
 =>
 (assert (Act P)))
(defrule ZZ
 (10JQKA Zer)
 (DecksCount Zer)
 =>
 (assert (Act Z)))
(defrule ZN
 (10JQKA Zer)
 (DecksCount Neg)
 =>
 (assert (Act N)))
(defrule NP
 (10JQKA Neg)
 (DecksCount Pos)
 =>
 (assert (Act Z)))
(defrule NZ
 (10JQKA Neg)
 (DecksCount Zer)
 =>
 (assert (Act N)))
(defrule NN
 (10JQKA Neg)
 (DecksCount Neg)
 =>
 (assert (Act BN)))



;********************************************************



(deffacts startup
(start))
