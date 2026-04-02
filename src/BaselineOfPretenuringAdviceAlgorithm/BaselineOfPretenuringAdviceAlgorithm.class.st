Class {
	#name : 'BaselineOfPretenuringAdviceAlgorithm',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPretenuringAdviceAlgorithm',
	#package : 'BaselineOfPretenuringAdviceAlgorithm'
}

{ #category : 'baselines' }
BaselineOfPretenuringAdviceAlgorithm >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		spec package: 'Pretenuring-Advice-Algorithm'.
		spec package: 'Pretenuring-Advice-Algorithm-Tests' with: [ spec requires: #( 'Pretenuring-Advice-Algorithm' ) ].

		"Groups"
		spec group: 'default' with: #( 'core' 'tests' ).
		spec group: 'core' with: #( 'Pretenuring-Advice-Algorithm' ).
		spec group: 'tests' with: #( 'Pretenuring-Advice-Algorithm-Tests' ) ]
]
