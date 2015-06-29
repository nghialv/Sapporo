# Sapporo

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![CocoaPods](https://img.shields.io/cocoapods/v/Future.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]
(https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/nghialv/Future.svg?style=flat
)](https://github.com/nghialv/Future/issues?state=open)

cellmodel-driven collectionview manager

Features
-----
* Easily manage your sections and cells (reset/insert/append/remove/update)
* Don't have to write the code for `UICollectionViewDelegate` and `UICollectionViewDataSource` protocols
* Don't need to care about cell identifier
* Handle cell selection by trailing closure
* Supports method chaining
* Supports subscript
* Complete example

##### Quick example

``` swift
	// viewController swift file
	
	let sapporo = Sapporo(collectionView: self.collectionView)
	
	let cellmodel = YourCellModel(title: "Title", des: "description") {
		println("Did select cell with title = \(title)")
	}
	
	let topSection = sapporo[TopSection]
	
	topSection.append(cellmodel) 				// append a new cell model in datasource
			  .bump()							// show the new cell in the collection view
	
	topSection.remove(1...3)
			  .bump()
			 
	topSection.move(fromIndex: 0, toIndex: 3)
			  .bump()
```
``` swift
	// your cell swift file
	
	class YourCellModel : SACellModel {
		let title: String
		let des: String
		
		init(title: String, des: String, selectionHandler: SASelectionHandler) {
			self.title = title
			self.des = des
			super.init(cellType: YourCell.self, selectionHandler: selectionHandler)
		}
	}
	

	class YourCell : SACell {
		@IBOutlet weak var titleLabel: UILabel!
    
		override func configureCell(cellmodel: SACellModel) {
			super.configure(cellmodel)
			if let cellmodel = cellmodel as? YourCellModel {
				titleLabel.text = cellmodel.title
        	}
      	}
	}
```

Usage
-----

* Handling section

``` swift
	// retrieve a section or create a new section if it doesn't already exist
	let section = sapporo[0]	
	
	// inserting
	sapporo.insert(section, atIndex: 1)
		   .bump()
	
	// moving
	sapporo.move(fromIndex: 1, toIndex: 5)
		   .bump()
	
	// removing
	sapporo.remove(index)
	   	   .bump()
	
	sapporo.reset()		// remove all data
		   .bump()
		   
 
	// handing section index by enum
	enum Section : Int, SectionIndex {
		case Top = 0
		case Center
		case Bottom
		
		var intValue: Int {
			return self.rawValue
    	}
	}
	
	let topSection = sapporo[Section.Top]
```

* Handling cell

``` swift
	// appending
	sapporo[0].append(cellmodel)				// append a cellmodel
		      .bump()							// and bump to show the cell in the collection view

	sapporo[TopSection].append(cellmodels)		// append a list of cellmodels
		  			   .bump()					
	
	// by using section
	let section = sapporo[Section.Top]
	section.append(cellmodel)
		   .bump()


	// 2. inserting
	section.insert(cellmodels, atIndex: 1)
		   .bump()
		   
	section.insertBeforeLast(cellmodels)
		   .bump()
	
	
	// 3. reseting
	section.reset(cellmodels)				// replace current data in section by the new data
		   .bump()
		   
	section.reset()							// or remove all data in section
		   .bump()
		   

	// 4. moving
	section.move(fromIndex: 5, toIndex: 1)
		   .bump()
	
	// 5. removing
	section.remove(1)
		   .bump()
	
	section.remove(cellmodel)
		   .bump()
		   
	section.remove(2...5)
		   .bump()
		   
	section.removeLast()
	       .bump()

	// updating cell
	let cellmodel = section[1]
	cellmodel.property = newData
	cellmodel.bump()
	
	// able to retrieve a cellmodel by indexpath
	let cellmodel = sapporo[indexpath]
```


* Registering cell, header, footer, reusable view

``` swift
	sapporo.registerNibForClass(CustomCell)
	sapporo.registerClass(SimpleCell)
	sapporo.registerNibForSupplementaryClass(HeaderView.self, kind: "SectionHeader")
```

* Customizing layout

In case you want to customize the layout of collection view, just create a subclass of SALayout and call `setLayout` method to set the new layout instance.

``` swift
	class CustomLayout: SALayout {
		// the implementation for your layout
	}
	
	let layout = CustomLayout()
	sapporo.setLayout(layout)
```

Demo apps
-----

Do you worry about the customizability when using `Sapporo`?
This is the answer for you, a calendar app implemented by using `Sapporo`.

Installation
-----
* Using Carthage
	- Insert github `nghialv/Sapporo` to your Cartfile
	- Run `carthage update`
	
* Using CocoaPods
	- Insert `use_frameworks!` to your Podfile
	- Insert `pod 'Sapporo'` to your Podfile
	- Run `pod install`

* Using submodule

Requirements
-----
- iOS 8.0+
- Swift 1.2

License
-----

Sapporo is released under the [MIT License](https://github.com/nghialv/Sapporo/blob/master/LICENSE).