//
//  CalendarLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

import UIKit
import Sapporo

let DaysPerWeek         : CGFloat = 7
let HoursPerDay         : CGFloat = 24
let HorizontalSpacing   : CGFloat = 10
let HeightPerHour       : CGFloat = 50
let DayHeaderHeight     : CGFloat = 40
let HourHeaderWidth     : CGFloat = 100

class CalendarLayout: SALayout {
    override func collectionViewContentSize() -> CGSize {
        let contentWidth = collectionView!.bounds.size.width
        let contentHeight = CGFloat(DayHeaderHeight + (HeightPerHour * HoursPerDay))
        
        return CGSizeMake(contentWidth, contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Cells
        let visibleIndexPaths = indexPathsOfItemsInRect(rect)
        layoutAttributes += visibleIndexPaths.map {
            self.layoutAttributesForItemAtIndexPath($0)
        }
        
        // Supplementary views
        let dayHeaderViewIndexPaths = indexPathsOfDayHeaderViewsInRect(rect)
        layoutAttributes += dayHeaderViewIndexPaths.map {
            self.layoutAttributesForSupplementaryViewOfKind(CalendarHeaderType.Day.rawValue, atIndexPath: $0)
        }
        
        let hourHeaderViewIndexPaths = indexPathsOfHourHeaderViewsInRect(rect)
        layoutAttributes += hourHeaderViewIndexPaths.map {
            self.layoutAttributesForSupplementaryViewOfKind(CalendarHeaderType.Hour.rawValue, atIndexPath: $0)
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        if let event = (getCellModel(indexPath) as? CalendarEventCellModel)?.event {
            attributes.frame = frameForEvent(event)
        }
        return attributes
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        
        let totalWidth = collectionViewContentSize().width
        
        if elementKind == CalendarHeaderType.Day.rawValue {
            let availableWidth = totalWidth - HourHeaderWidth
            let widthPerDay = availableWidth / DaysPerWeek
            attributes.frame = CGRectMake(HourHeaderWidth + (widthPerDay * CGFloat(indexPath.item)), 0, widthPerDay, DayHeaderHeight)
            attributes.zIndex = -10
        } else if elementKind == CalendarHeaderType.Hour.rawValue {
            attributes.frame = CGRectMake(0, DayHeaderHeight + HeightPerHour * CGFloat(indexPath.item), totalWidth, HeightPerHour)
            attributes.zIndex = -10
        }
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}

extension CalendarLayout {
    func indexPathsOfEventsBetweenMinDayIndex(minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        
        if let cellmodels = getCellModels(0) as? [CalendarEventCellModel] {
            for i in 0..<cellmodels.count {
                let event = cellmodels[i].event
                if event.day >= minDayIndex && event.day <= maxDayIndex && event.startHour >= minStartHour && event.startHour <= maxStartHour {
                    let indexPath = NSIndexPath(forItem: i, inSection: 0)
                    indexPaths.append(indexPath)
                }
            }
        }
        return indexPaths
    }
    
    func indexPathsOfItemsInRect(rect: CGRect) -> [NSIndexPath] {
        let minVisibleDay = dayIndexFromXCoordinate(CGRectGetMinX(rect))
        let maxVisibleDay = dayIndexFromXCoordinate(CGRectGetMaxX(rect))
        let minVisibleHour = hourIndexFromYCoordinate(CGRectGetMinY(rect))
        let maxVisibleHour = hourIndexFromYCoordinate(CGRectGetMaxY(rect))
        
        return indexPathsOfEventsBetweenMinDayIndex(minVisibleDay, maxDayIndex: maxVisibleDay, minStartHour: minVisibleHour, maxStartHour: maxVisibleHour)
    }
    
    func dayIndexFromXCoordinate(xPosition: CGFloat) -> Int {
        let contentWidth = collectionViewContentSize().width - HourHeaderWidth
        let widthPerDay = contentWidth / DaysPerWeek
        
        let dayIndex = max(0, Int((xPosition - HourHeaderWidth) / widthPerDay))
        return dayIndex
    }
    
    func hourIndexFromYCoordinate(yPosition: CGFloat) -> Int {
        let hourIndex = max(0, Int((yPosition - DayHeaderHeight) / HeightPerHour))
        return hourIndex
    }
    
    func indexPathsOfDayHeaderViewsInRect(rect: CGRect) -> [NSIndexPath] {
        if CGRectGetMinY(rect) > DayHeaderHeight {
            return []
        }
        
        let minDayIndex = dayIndexFromXCoordinate(CGRectGetMinX(rect))
        let maxDayIndex = dayIndexFromXCoordinate(CGRectGetMaxX(rect))
        
        return (minDayIndex...maxDayIndex).map { index -> NSIndexPath in
            NSIndexPath(forItem: index, inSection: 0)
        }
    }
    
    func indexPathsOfHourHeaderViewsInRect(rect: CGRect) -> [NSIndexPath] {
        if CGRectGetMinX(rect) > HourHeaderWidth {
            return []
        }
        
        let minHourIndex = hourIndexFromYCoordinate(CGRectGetMinY(rect))
        let maxHourIndex = hourIndexFromYCoordinate(CGRectGetMaxY(rect))
        
        return (minHourIndex...maxHourIndex).map { index -> NSIndexPath in
            NSIndexPath(forItem: index, inSection: 0)
        }
    }
    
    func frameForEvent(event: CalendarEvent) -> CGRect {
        let totalWidth = collectionViewContentSize().width - HourHeaderWidth
        let widthPerDay = totalWidth / DaysPerWeek
        
        var frame = CGRectZero
        frame.origin.x = HourHeaderWidth + widthPerDay * CGFloat(event.day)
        frame.origin.y = DayHeaderHeight + HeightPerHour * CGFloat(event.startHour)
        frame.size.width = widthPerDay
        frame.size.height = CGFloat(event.durationInHours) * HeightPerHour
        
        frame = CGRectInset(frame, HorizontalSpacing/2.0, 0)
        return frame
    }
}