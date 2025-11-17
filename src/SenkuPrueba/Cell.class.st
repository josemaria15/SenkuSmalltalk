Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'estado'
	],
	#category : 'SenkuPrueba',
	#package : 'SenkuPrueba'
}

{ #category : 'initialization' }
Cell >> beEmpty [
    estado := #empty.

]

{ #category : 'initialization' }
Cell >> beInvalid [
    estado := #invalid.

]

{ #category : 'initialization' }
Cell >> bePeg [
    estado := #peg.

]

{ #category : 'accessing' }
Cell >> estado [
    ^ estado

]

{ #category : 'testing' }
Cell >> hasPeg [
    ^ estado = #peg.

]

{ #category : 'testing' }
Cell >> isEmpty [
    ^ estado = #empty.

]

{ #category : 'testing' }
Cell >> isInvalid [
    ^ estado = #invalid.

]
