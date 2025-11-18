Class {
	#name : 'SenkuBoardMorph',
	#superclass : 'Morph',
	#instVars : [
		'game'
	],
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'initialization' }
SenkuBoardMorph >> initialize [
    "Crea el tablero, dibuja la cruz gris y coloca las celdas."
    | celdaGrafica celdaLogica crossVertical crossHorizontal margin gridStep | 
    
    super initialize.
    
    "1. Configura el juego (Lógica)"
    game := SenkuGame new.
    game initialize.
    
    "2. Configura las variables de dibujo"
    margin := 5. "¡AQUÍ ESTÁ EL MARGEN!"
    gridStep := 55. "El espacio de tu grilla (50 de celda + 5 de gap)"

    "3. Configura el fondo"
    self color: (Color gray darker).
    self extent: 400@400. 

    "4. DIBUJA LA CRUZ GRIS CLARA (ajustada por el margen)"
    
    "Rectángulo Vertical"
    crossVertical := Morph new.
    crossVertical color: (Color gray lighter).
    crossVertical position: (2 * gridStep - margin) @ (0 - margin).
    crossVertical extent: (3 * gridStep + (margin * 2)) @ (7 * gridStep + (margin * 2)).
    crossVertical borderWidth: 2; borderColor: #raised.
    self addMorph: crossVertical.

    "Rectángulo Horizontal"
    crossHorizontal := Morph new.
    crossHorizontal color: (Color gray lighter).
    crossHorizontal position: (0 - margin) @ (2 * gridStep - margin).
    crossHorizontal extent: (7 * gridStep + (margin * 2)) @ (3 * gridStep + (margin * 2)).
    crossHorizontal borderWidth: 2; borderColor: #raised.
    self addMorph: crossHorizontal.

    "5. DIBUJAR LOS CÍRCULOS (Este código no cambia)"
    "Los círculos se dibujan en sus posiciones originales"
    1 to: 7 do: [:row |
        1 to: 7 do: [:col |
            
            celdaLogica := (game board at: row) at: col.
            
            (celdaLogica isInvalid) ifFalse: [
            
                celdaGrafica := CellMorph new. 
                "La posición del círculo sigue siendo la misma"
                celdaGrafica position: ((col - 1) * gridStep) @ ((row - 1) * gridStep).
            
                (celdaLogica hasPeg) 
                    ifTrue: [ celdaGrafica color: Color blue ].
            
                (celdaLogica isEmpty)
                    ifTrue: [ celdaGrafica color: (Color gray) ]. 
            
                self addMorph: celdaGrafica.
            ].
        ].
    ].
]
