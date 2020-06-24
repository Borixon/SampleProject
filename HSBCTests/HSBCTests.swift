//
//  HSBCTests.swift
//  HSBCTests
//
//  Created by Michał Krupa on 22/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import XCTest
@testable import HSBC

class HSBCTests: XCTestCase {


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_CityViewModelWithData() {
        let model = CityModel(id: 0, name: "Name", imageURL: "StringURL")
        let geolocation = GeolocationProtocol(longitude: 100, latidute: 100)
        let viewModel = CityViewModel()
        let data = CityDetailsDecodableProtocol(id: 0,
                                                cityDescription: "Description",
                                                detailText: "Details",
                                                rating: 5,
                                                population: 6000,
                                                geolocation: geolocation)
        model.update(data: data)
        viewModel.model = model
        
        let string0: String? = viewModel.dataFor(indexPath: IndexPath(row: 0, section: 1))
        let string1: String? = viewModel.dataFor(indexPath: IndexPath(row: 1, section: 1))
        let string2: String? = viewModel.dataFor(indexPath: IndexPath(row: 2, section: 1))
        let string3: String? = viewModel.dataFor(indexPath: IndexPath(row: 100, section: 1))
        
        XCTAssertNotNil(string0)
        XCTAssertNotNil(string1)
        XCTAssertNotNil(string2)
        XCTAssertEqual(string2, string3)
    }

    func test_ViewModelsInitialState() throws {
        let emptyString = ""
        
        let mainViewModel = MainViewModel()
        XCTAssertNotEqual(mainViewModel.citySegueIndeifier, emptyString)
        XCTAssertNotEqual(mainViewModel.emptyCellIdentifier, emptyString)
        XCTAssertNotEqual(mainViewModel.emptyCellNib, emptyString)
        XCTAssertNotEqual(mainViewModel.mediaCellIdentifier, emptyString)
        XCTAssertNotEqual(mainViewModel.mediaCellNib, emptyString)
        XCTAssertNotEqual(mainViewModel.navigationTitle, emptyString)
        XCTAssertEqual(mainViewModel.numberOfElements, 1)
        XCTAssertEqual(mainViewModel.emptyTable, true)
        XCTAssertNil(mainViewModel.viewModel(IndexPath(row: 0, section: 0)))
        
        let cityViewModel = CityViewModel()
        XCTAssertNotEqual(cityViewModel.commonCellIdentifier, emptyString)
        XCTAssertNotEqual(cityViewModel.headerCellIdentifier, emptyString)
        XCTAssertNotEqual(cityViewModel.headerNibName, emptyString)
        XCTAssertNotEqual(cityViewModel.infoNibName, emptyString)
        XCTAssertEqual(cityViewModel.numberOfSections, 2)
    }
}
