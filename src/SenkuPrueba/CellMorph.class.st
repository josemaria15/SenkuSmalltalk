Class {
	#name : 'CellMorph',
	#superclass : 'EllipseMorph',
	#instVars : [
		'row',
		'col'
	],
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'accessing' }
CellMorph >> col [
    ^ col
]

{ #category : 'accessing' }
CellMorph >> col: unNumero [
    col := unNumero
]

{ #category : 'event handling' }
CellMorph >> handlesMouseDown: anEvent [
    ^ true
]

{ #category : 'initialization' }
CellMorph >> initialize [
	"Inicializa una SOLA celda."
	
	super initialize.
	
	self extent: 50@50. "Extensión (ancho y alto) de la celda"
	self color: (Color gray lighter). "Color base"
]

{ #category : 'event handling' }
CellMorph >> mouseDown: anEvent [
    "Le avisamos al tablero (nuestro dueño) que fuimos clickeados"
    self owner cellClicked: self.
]

{ #category : 'accessing' }
CellMorph >> row [
    ^ row
]

{ #category : 'accessing' }
CellMorph >> row: unNumero [
    row := unNumero
]
