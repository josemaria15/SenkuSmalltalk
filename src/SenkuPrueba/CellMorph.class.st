Class {
	#name : 'CellMorph',
	#superclass : 'EllipseMorph',
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'initialization' }
CellMorph >> initialize [
	"Inicializa una SOLA celda."
	
	super initialize.
	
	self extent: 50@50. "Extensión (ancho y alto) de la celda"
	self color: (Color gray lighter). "Color base"
]
