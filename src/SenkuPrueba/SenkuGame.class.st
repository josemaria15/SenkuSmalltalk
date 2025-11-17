Class {
	#name : 'SenkuGame',
	#superclass : 'Object',
	#instVars : [
		'board'
	],
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'accessing' }
SenkuGame >> board [
    ^ board

]

{ #category : 'accessing' }
SenkuGame >> board: aBoard [
    board := aBoard

]

{ #category : 'initialization' }
SenkuGame >> initialize [
    super initialize.
    self initializeBoard.

]

{ #category : 'initialization' }
SenkuGame >> initializeBoard [
    board := Array new: 7.

    1 to: 7 do: [:row |
        board at: row put: (Array new: 7).
    ].

    1 to: 7 do: [:row |
        1 to: 7 do: [:col |
            (board at: row) at: col put: Cell new.
        ].
    ].

]

{ #category : 'set up' }
SenkuGame >> setupStandardBoard [
    1 to: 7 do: [:row |
        1 to: 7 do: [:col |
            | cell |
            cell := (board at: row) at: col.

            "Región inválida (forma de cruz)"
            ((row <= 2 or: [row >= 6]) and: [
                (col <= 2 or: [col >= 6])])
                ifTrue: [cell beInvalid]
                ifFalse: [cell bePeg].
        ].
    ].

    "Casilla central vacía"
    ((board at: 4) at: 4) beEmpty.

]
