//
//  SABumpTracker.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import Foundation

private enum UpdateState {
	case begin
	case reload
	case insert([Int])
	case move(Int, Int)
	case remove([Int])
}

final class SABumpTracker {
	fileprivate var state = UpdateState.begin
	
    var changed: Bool {
        if case .begin = state {
            return false
        }
        return true
    }
    
	func didBump() {
		state = .begin
	}
	
	func didReset() {
		state = .reload
	}
	
	func didInsert(_ indexes: [Int]) {
		switch state {
		case .begin:
			state = .insert(indexes)
            
		default:
			state = .reload
		}
	}
	
	func didMove(_ from: Int, to: Int) {
		switch state {
		case .begin:
			state = .move(from, to)
            
		default:
			state = .reload
		}
	}
	
	func didRemove(_ indexes: [Int]) {
		switch state {
		case .begin:
			state = .remove(indexes)
            
		default:
			state = .reload
		}
	}
	
	func getSectionBumpType(_ index: Int) -> SectionBumpType {
		let toIndexPath = { (row: Int) -> IndexPath in
			return IndexPath(row: row, section: index)
		}
		
		switch state {
		case .insert(let indexes):
			return .insert(indexes.map(toIndexPath))
            
		case .move(let from, let to):
			return .move(toIndexPath(from), toIndexPath(to))
            
		case .remove(let indexes):
			return .delete(indexes.map(toIndexPath))
            
		default:
			return .reload(IndexSet(integer: index))
		}
	}
	
	func getSapporoBumpType() -> SapporoBumpType {
		let toIndexSet = { (indexes: [Int]) -> IndexSet in
			let indexSet = NSMutableIndexSet()
			for index in indexes {
				indexSet.add(index)
			}
			return indexSet as IndexSet
		}
		
		switch state {
		case .insert(let indexes):
			return .insert(toIndexSet(indexes))
            
		case .move(let from, let to):
			return .move(from, to)
            
		case .remove(let indexes):
			return .delete(toIndexSet(indexes))
            
		default:
			return .reload
		}
	}
}
