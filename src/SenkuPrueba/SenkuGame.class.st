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
    "Crea un tablero 7x7 y asigna el estado correcto
    a cada celda según las reglas del solitario inglés."

    board := Array new: 7.

    "Crear las 7 filas del tablero"
    1 to: 7 do: [:row |
        board at: row put: (Array new: 7).
    ].

    "Crear cada celda y asignar su estado"
    1 to: 7 do: [:row |
        1 to: 7 do: [:col |

            | celda |
            celda := Cell new.

            "1) Las esquinas deben ser INVALID"
            ((row <= 2 or: [row >= 6]) and: [col <= 2 or: [col >= 6]])
                ifTrue: [
                    celda beInvalid 
                ]
                ifFalse: [

                    "2) El centro (4,4) debe estar vacío"
                    (row = 4 and: [col = 4])
                        ifTrue: [
                            celda beEmpty 
                        ]
                        ifFalse: [

                            "3) Todas las demás posiciones válidas tienen peg"
                            celda bePeg 
                        ].
                ].

            "Guardar la celda en el tablero"
            (board at: row) at: col put: celda.
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
