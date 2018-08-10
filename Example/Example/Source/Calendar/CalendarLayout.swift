//
//  CalendarLayout.swift
//  Example
//
//  Created by Le VanNghia on 6/29/15.
//  Copyright (c) 2015 Le Van Nghia. All rights reserved.
//

// http://www.objc.io/issues/3-views/collection-view-layouts

import UIKit
import Sapporo

let DaysPerWeek: CGFloat = 7
let HoursPerDay: CGFloat = 24
let HorizontalSpacing: CGFloat = 10
let HeightPerHour: CGFloat = 50
let DayHeaderHeight: CGFloat = 40
let HourHeaderWidth: CGFloat = 100

final class CalendarLayout: SALayout {
    override var collectionViewContentSize: CGSize {
        let contentWidth = collectionView!.bounds.size.width
        let contentHeight = CGFloat(DayHeaderHeight + (HeightPerHour * HoursPerDay))
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Cells
        let visibleIndexPaths = indexPathsOfItemsInRect(rect)
        layoutAttributes += visibleIndexPaths.compactMap {
            self.layoutAttributesForItem(at: $0)
        }
        
        // Supplementary views
        let dayHeaderViewIndexPaths = indexPathsOfDayHeaderViewsInRect(rect)
        layoutAttributes += dayHeaderViewIndexPaths.compactMap {
            self.layoutAttributesForSupplementaryView(ofKind: CalendarHeaderType.day.rawValue, at: $0)
        }
        
        let hourHeaderViewIndexPaths = indexPathsOfHourHeaderViewsInRect(rect)
        layoutAttributes += hourHeaderViewIndexPaths.compactMap {
            self.layoutAttributesForSupplementaryView(ofKind: CalendarHeaderType.hour.rawValue, at: $0)
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        if let event = (getCellModel(indexPath) as? CalendarEventCellModel)?.event {
            attributes.frame = frameForEvent(event)
        }
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        
        let totalWidth = collectionViewContentSize.width
        
        if elementKind == CalendarHeaderType.day.rawValue {
            let availableWidth = totalWidth - HourHeaderWidth
            let widthPerDay = availableWidth / DaysPerWeek
            attributes.frame = .init(
                x: HourHeaderWidth + (widthPerDay * CGFloat(indexPath.item)),
                y: 0,
                width: widthPerDay,
                height: DayHeaderHeight
            )
            attributes.zIndex = -10
        } else if elementKind == CalendarHeaderType.hour.rawValue {
            attributes.frame = .init(
                x: 0,
                y: DayHeaderHeight + HeightPerHour * CGFloat(indexPath.item),
                width: totalWidth,
                height: HeightPerHour
            )
            attributes.zIndex = -10
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

extension CalendarLayout {
    func indexPathsOfEventsBetweenMinDayIndex(_ minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [IndexPath] {
        guard let cellModels = getCellModels(0) as? [CalendarEventCellModel] else {
            return []
        }
        var indexPaths: [IndexPath] = []
        
        for (index, cellModel) in cellModels.enumerated()
            where cellModel.event.day >= minDayIndex && cellModel.event.day <= maxDayIndex && cellModel.event.startHour >= minStartHour && cellModel.event.startHour <= maxStartHour {
                let indexPath = IndexPath(item: index, section: 0)
                indexPaths.append(indexPath)
        }
        
        return indexPaths
    }
    
    func indexPathsOfItemsInRect(_ rect: CGRect) -> [IndexPath] {
        let minVisibleDay = dayIndexFromXCoordinate(rect.minX)
        let maxVisibleDay = dayIndexFromXCoordinate(rect.maxX)
        let minVisibleHour = hourIndexFromYCoordinate(rect.minY)
        let maxVisibleHour = hourIndexFromYCoordinate(rect.maxY)
        
        return indexPathsOfEventsBetweenMinDayIndex(minVisibleDay, maxDayIndex: maxVisibleDay, minStartHour: minVisibleHour, maxStartHour: maxVisibleHour)
    }
    
    func dayIndexFromXCoordinate(_ xPosition: CGFloat) -> Int {
        let contentWidth = collectionViewContentSize.width - HourHeaderWidth
        let widthPerDay = contentWidth / DaysPerWeek
        
        let dayIndex = max(0, Int((xPosition - HourHeaderWidth) / widthPerDay))
        return dayIndex
    }
    
    func hourIndexFromYCoordinate(_ yPosition: CGFloat) -> Int {
        let hourIndex = max(0, Int((yPosition - DayHeaderHeight) / HeightPerHour))
        return hourIndex
    }
    
    func indexPathsOfDayHeaderViewsInRect(_ rect: CGRect) -> [IndexPath] {
        if rect.minY > DayHeaderHeight {
            return []
        }
        
        let minDayIndex = dayIndexFromXCoordinate(rect.minX)
        let maxDayIndex = dayIndexFromXCoordinate(rect.maxX)
        
        return (minDayIndex...maxDayIndex).map { index -> IndexPath in
            IndexPath(item: index, section: 0)
        }
    }
    
    func indexPathsOfHourHeaderViewsInRect(_ rect: CGRect) -> [IndexPath] {
        if rect.minX > HourHeaderWidth {
            return []
        }
        
        let minHourIndex = hourIndexFromYCoordinate(rect.minY)
        let maxHourIndex = hourIndexFromYCoordinate(rect.maxY)
        
        return (minHourIndex...maxHourIndex).map { index -> IndexPath in
            IndexPath(item: index, section: 0)
        }
    }
    
    func frameForEvent(_ event: CalendarEvent) -> CGRect {
        let totalWidth = collectionViewContentSize.width - HourHeaderWidth
        let widthPerDay = totalWidth / DaysPerWeek
        
        var frame = CGRect.zero
        frame.origin.x = HourHeaderWidth + widthPerDay * CGFloat(event.day)
        frame.origin.y = DayHeaderHeight + HeightPerHour * CGFloat(event.startHour)
        frame.size.width = widthPerDay
        frame.size.height = CGFloat(event.durationInHours) * HeightPerHour
        
        frame = frame.insetBy(dx: HorizontalSpacing / 2.0, dy: 0)
        return frame
    }
}
