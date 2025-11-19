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

{ #category : 'game logic' }
SenkuGame >> moveFrom: r1 at: c1 to: r2 at: c2 [
    "Mueve una ficha desde (r1,c1) a (r2,c2) comiendo la del medio.
     Retorna true si el movimiento fue válido y realizado."

    | dFila dCol filaMedio colMedio cInicio cFin cMedio |

    "1. VALIDACIÓN GEOMÉTRICA"
    dFila := r1 - r2.
    dCol := c1 - c2.

    "Debe ser recto (solo cambia una coordenada)"
    ((dFila = 0) or: [ dCol = 0 ]) ifFalse: [ ^ false ].

    "Debe moverse exactamente 2 posiciones"
    ((dFila abs + dCol abs) = 2) ifFalse: [ ^ false ].

    "2. CALCULAR LA CELDA DEL MEDIO (LA FICHA A COMER)"
    filaMedio := (r1 + r2) // 2.
    colMedio := (c1 + c2) // 2.

    "3. OBTENER CELDAS DEL TABLERO"
    cInicio := (board at: r1) at: c1.
    cFin := (board at: r2) at: c2.
    cMedio := (board at: filaMedio) at: colMedio.

    "4. VALIDACIONES DE ESTADO"
    (cInicio hasPeg) ifFalse: [ ^ false ]. "Debe haber ficha en origen"
    (cFin isEmpty) ifFalse: [ ^ false ].   "Destino debe estar vacío"
    (cMedio hasPeg) ifFalse: [ ^ false ].  "Debe haber ficha para comer"

    "5. EJECUCIÓN"
    cInicio beEmpty.  "Quito ficha origen"
    cMedio beEmpty.   "Como ficha del medio"
    cFin bePeg.       "Pongo ficha en destino"

    ^ true

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
