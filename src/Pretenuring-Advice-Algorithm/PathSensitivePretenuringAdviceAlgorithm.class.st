Class {
	#name : 'PathSensitivePretenuringAdviceAlgorithm',
	#superclass : 'MerlinPretenuringAdviceAlgorithm',
	#instVars : [
		'ambiguityThreshold'
	],
	#category : 'Pretenuring-Advice-Algorithm-Allocation-Site-Classification',
	#package : 'Pretenuring-Advice-Algorithm',
	#tag : 'Allocation-Site-Classification'
}

{ #category : 'initialization' }
PathSensitivePretenuringAdviceAlgorithm >> ambiguityThreshold: aNumber [

	ambiguityThreshold := aNumber
]

{ #category : 'calculating' }
PathSensitivePretenuringAdviceAlgorithm >> classifyAllocationSites [

	groupedAllocationSites keysAndValuesDo: [ :allocationGraphEdge :allocationSiteBin |
		| is ss ls wasClassified |
		wasClassified := false.
		is := allocationSiteBin immortalObjects sum: #sizeInBytes.
		ss := allocationSiteBin shortLivedObjects sum: #sizeInBytes.
		ls := allocationSiteBin longLivedObjects sum: #sizeInBytes.

		(is + ls) > ((is + ss + ls) * ambiguityThreshold) ifTrue: [
			allocationSiteBin classification: #long.
			allocationGraphEdge beLongLived.
			wasClassified := true ].
		wasClassified ifFalse: [
			allocationSiteBin classification: #ambiguous.
			allocationGraphEdge beAmbiguous ] ]
]

{ #category : 'initialization' }
PathSensitivePretenuringAdviceAlgorithm >> initialize [

	super initialize.
	ambiguityThreshold := 0.9
]
