Class {
	#name : 'SenkuBoardMorph',
	#superclass : 'Morph',
	#instVars : [
		'game',
		'selectedCell'
	],
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'event handling' }
SenkuBoardMorph >> cellClicked: unaCelda [
    "Gestiona la interacción del usuario: Seleccionar, Cambiar y Mover."

    "CASO 1: No hay nada seleccionado aún"
    selectedCell ifNil: [
        "Solo permitimos seleccionar si es una FICHA (azul)"
        (unaCelda color = Color blue) ifTrue: [ 
            self selectCell: unaCelda.
        ].
        ^ self.
    ].

    "CASO 2: Ya había una ficha seleccionada..."
    
    "2A. ¿Clicó la MISMA ficha? -> Cancelar selección"
    unaCelda = selectedCell ifTrue: [ 
        self deselectCell.
        ^ self.
    ].

    "2B. ¿Clicó OTRA ficha azul? -> Cambiar selección"
    (unaCelda color = Color blue) ifTrue: [
        self deselectCell.
        self selectCell: unaCelda.
        ^ self.
    ].

    "2C. ¿Clicó un HUECO (Negro)? -> ¡Intentar Mover!"
    (unaCelda color = Color black) ifTrue: [
        | movio |
        
        movio := game moveFrom: selectedCell row at: selectedCell col
                      to: unaCelda row at: unaCelda col.
        
        movio ifTrue: [
            "EXITO: Solo limpiamos la variable, NO cambiamos color manual"
            selectedCell := nil. 
            
            "UpdateView pintará todo correcto (incluyendo el origen a negro)"
            self updateView. 
            Transcript show: '¡Movimiento exitoso!'; cr.
        ] ifFalse: [
            "FALLO: Aquí sí deseleccionamos visualmente (vuelve a azul)"
            self deselectCell.
            Transcript show: 'Movimiento inválido'; cr.
        ].
        
        "IMPORTANTE: Borra el 'self deselectCell' que tenías al final fuera del if"
    ].
]

{ #category : 'interaction' }
SenkuBoardMorph >> deselectCell [
    "Si hay algo seleccionado, lo pinta de azul (o su color original) y borra la memoria"
    selectedCell ifNotNil: [
        selectedCell color: Color blue. 
        selectedCell := nil.
    ].
]

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
                
                "--- NUEVAS LÍNEAS: Asignar Identidad ---"
                celdaGrafica row: row.
                celdaGrafica col: col.
                "----------------------------------------"

                celdaGrafica position: ((col - 1) * 55) @ ((row - 1) * 55).
            
                (celdaLogica hasPeg) 
                    ifTrue: [ celdaGrafica color: Color blue ].
            
                (celdaLogica isEmpty)
                    ifTrue: [ celdaGrafica color: Color black ].
            
                self addMorph: celdaGrafica.
            ].
        ].
    ].
]

{ #category : 'interaction' }
SenkuBoardMorph >> selectCell: unaCelda [
    "Guarda la celda y la pinta de verde"
    selectedCell := unaCelda.
    unaCelda color: Color green.
]

{ #category : 'drawing' }
SenkuBoardMorph >> updateView [
    "Recorre el tablero visual y fuerza el color según el estado lógico exacto.
     Reglas de Visualización:
     - Si es #empty (Hueco) -> NEGRO (Se aplica a Origen y Medio tras saltar)
     - Si es #peg (Ficha)   -> AZUL  (Se aplica a Destino tras saltar)
     - Si es #invalid       -> Ignorar/Gris"

    self submorphs do: [:morphCelda | 
        
        "Verificamos que sea una celda del juego"
        (morphCelda respondsTo: #row) ifTrue: [
             | celdaLogica |
             
             "Obtenemos el objeto lógico (la memoria del juego)"
             celdaLogica := (game board at: morphCelda row) at: morphCelda col.

             "1. REGLA DE HUECOS (Origen y Medio comido)"
             (celdaLogica isEmpty) ifTrue: [ 
                 morphCelda color: Color black.
             ].

             "2. REGLA DE FICHAS (Destino)"
             (celdaLogica hasPeg) ifTrue: [ 
                 morphCelda color: Color blue.
             ].
             
             "Nota: Al usar ifTrue separados, evitamos confusiones de ifFalse anidados."
        ]
    ].
]
