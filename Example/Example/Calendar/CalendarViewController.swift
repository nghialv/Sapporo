//
//  CalendarViewController.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

enum CalendarHeaderType: String {
    case Day    = "DayHeaderView"
    case Hour   = "HourHeaderView"
}

class CalendarViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var sapporo: Sapporo = { [unowned self] in
        return Sapporo(collectionView: self.collectionView)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sapporo.delegate = self
        sapporo.registerNibForClass(CalendarEventCell)
        sapporo.registerNibForSupplementaryClass(CalendarHeaderView.self, kind: CalendarHeaderType.Day.rawValue)
        sapporo.registerNibForSupplementaryClass(CalendarHeaderView.self, kind: CalendarHeaderType.Hour.rawValue)
        
        let layout = CalendarLayout()
        sapporo.setLayout(layout)
        
        let randomEvent = { () -> CalendarEvent in
            let randomID = arc4random_uniform(10000)
            let title = "Event \(randomID)"
            
            let randomDay = Int(arc4random_uniform(7))
            let randomStartHour = Int(arc4random_uniform(20))
            let randomDuration = Int(arc4random_uniform(5) + 1)
            
            return CalendarEvent(title: title, day: randomDay, startHour: randomStartHour, durationInHours: randomDuration)
        }
        
        let cellmodels = (0...20).map { _ -> CalendarEventCellModel in
            let event = randomEvent()
            return CalendarEventCellModel(event: event) { _ in
                println("Selected event: \(event.title)")
            }
        }
        
        sapporo[0].append(cellmodels)
        sapporo.bump()
    }
}

extension CalendarViewController: SapporoDelegate {
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == CalendarHeaderType.Day.rawValue {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: CalendarHeaderView.reuseIdentifier, forIndexPath: indexPath) as! CalendarHeaderView
            view.titleLabel.text = "Day \(indexPath.item + 1)"
            return view
        }
        
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: CalendarHeaderView.reuseIdentifier, forIndexPath: indexPath) as! CalendarHeaderView
        view.titleLabel.text = "Hour \(indexPath.item + 1)"
        return view
    }
}