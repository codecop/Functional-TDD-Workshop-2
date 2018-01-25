(include "assert.scm")

; data structure and its accessors = classic product type

(define (rover-new x y direction) ; narrowing down the arguments
    (list x y direction)
)

(define (rover-x rover)
    (car rover)
)

(define (rover-y rover)
    (car (cdr rover))
)

(define (rover-direction rover)
    (car (cdr (cdr rover)))
)

; (define (rover-move rover direction) ; -> rover
;     ...
; )

(define (rover-move-west rover)
    (rover-new (- (rover-x rover) 1) (rover-y rover) (rover-direction rover))
)
; all actions will look the same

(define (make-execute-commands obstacles)
    (define (execute-commands rover commands)
        ; TODO commands functions are low level, wrap in a type with methods
        ; like commands-empty, commands-tail, commands-new
        ; one kind of clean-up
        (if (= (string-length commands) 0) ; first case we testet, also base case, leave first.
            (list rover "")
            (execute-commands
                (rover-move-west rover)
                (substring commands 1 (string-length commands))
                ; this recursion is a reduction
                ; TODO use reduce function
            )
        )
    )
    execute-commands
)

; in API thinking I will need the grid/Mars.
; I can add it now, so I do not have to break code later.
(define (grid-new size-x size-y)
    (list size-x size-y)
)

(define (grid-x grid)
    (car grid)
)

(define (grid-y grid)
    (car (cdr grid))
)

; Idea: map list of commands to list of rovers and then iterate list and
; check size/wrapping and then validate against obstacles ...
; We started with the outside and now it would not be the outside any more. unclear.

(define (obstacles)
    (list)
)

; TEST

; 1st test idea - we started with the core business.
; (test-case "There is a rover and it can move forward"
;     (assert= (list 0 1 'N')
;              (rover (list 0 0 'N') 'f')))
;
; initial place with no movement should point to the same place
; lost (list 100 100)

; 2nd test idea
; (test-case "There is a rover"  ; PBT: true for all (x y D)
;     (assert= (list 0 0 'N')
;              (rover (list 0 0 'N') '')))

(test-case "A new rover has an x coordinate"
    (assert 0
             (rover-x (rover-new 0 1 "S") )))
; TODO check y and D as well

(define (rover-equals rovera roverb)
     (and
        (= (rover-x rovera) (rover-x roverb))
        (= (rover-y rovera) (rover-y roverb))
        (equal? (rover-direction rovera) (rover-direction roverb))
     )
)

(test-case "A rover is not equals in x"
    (assert "failed" (not (rover-equals (rover-new 0 0 "N") (rover-new 1 0 "N")))))

(test-case "A rover equals" ; PBT: for all (x y D)
    (assert "failed" (rover-equals (rover-new 1 1 "N") (rover-new 1 1 "N"))))
; some tests are concrete instances of wider properties

; (test-case "A rover is not equals in y"
; (test-case "A rover is not equals in direction"

(define (execute-commands-no-obstacles rover commands)
    (car ((make-execute-commands (obstacles)) rover commands)) ; TODO car is low level
)

; this is a "higher order" test, now I test a composition.
(test-case "There is a rover and it does not move on empty commands"
    (assert "failed"
        (rover-equals
             (rover-new 0 0 "N")
             (execute-commands-no-obstacles (rover-new 0 0 "N") ""))))

; Johannes wants to bring in all domain terms early, so we have less restucturing later.
; Dierk likes to have little code working because if it is tested we can change it easily.

(test-case "Rover moves forward"
    (assert "failed"
        (rover-equals
             (rover-new 2 4 "W")
             (execute-commands-no-obstacles (rover-new 3 4 "W") "f"))))

(test-case "Rover moves forward twice"
    (assert "failed"
        (rover-equals
             (rover-new 1 4 "W")
             (execute-commands-no-obstacles (rover-new 3 4 "W") "ff"))))

; because I can always add more arguments and use currying
; fn = (make-execute-commands (grid-new 100 100)
;                        (obstacles (list (obstacle-new 1 3)))
;                         (rover-new 1 2 "N")
;                         _) ... curried function to use as new execute-command

; TODO new test bringing in obstacles after all refactorings
; (test-case "Rover tries to move forward but hits obstacle"
;     (assert "failed"
;         (rover-equals
;              (list (rover-new 1 2 "N") "stopped at 1 2")
;              (make-execute-commands (obstacles (list (obstacle-new 1 3)))
;                                (rover-new 1 2 "N")
;                                "f"))))
; (test-case "Rover tries to move forward and reports obstacle"
; ...

; Retro
; Refactoring to add parameters: expanding list to the left and wrapping it
; Functional way is very fine grained.
; approach looks the same like in OO.
;   inductive, focused on naming, adding one after the other
