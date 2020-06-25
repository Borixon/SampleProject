 //
//  MainViewModel.swift
//  Preglife
//
//  Created by Michał Krupa on 14/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit
 
class MainViewModel {
    
    public let emptyCellNib = "EmptyTableViewCell"
    public let mediaCellNib = "CityCell"
    public let emptyCellIdentifier = "emptyCellIdentifier"
    public let mediaCellIdentifier = "mediaCellIdentifier"
    public let citySegueIndeifier = "showMediaSegue"
    public let navigationTitle = "Cities"
    
    private var cityModels: [CityModel] = [] {
        didSet {
            self.cityModels.sort(by: { $0.name < $01.name })
        }
    }
    
    weak var vc: MainViewController?
    
    public var emptyTable: Bool {
        return cityModels.isEmpty
    }
    
    public var numberOfElements: Int {
        if !emptyTable {
            return cityModels.count
        }
        return 1
    }
    
    public var cellHeight: CGFloat {
        if !emptyTable {
            return CityCell.height
        }
        return EmptyTableViewCell.height
    }
    
    // MARK: Public functions
    
    public func checkForData() {
        DataManager.shared.getCitiesList(completion: { data in
            if let models = data {
                self.cityModels = models
                self.vc?.tableView.reloadData()
            }
        })
    }
    
    public func viewModel(_ indexPath: IndexPath) -> CityCellViewModel? {
        guard let model = getMedia(forIndexPath: indexPath) else { return nil }
        return CityCellViewModel(city: model)
    }
    
    public func getMediaData(completion: @escaping (Bool, Error?) -> Void) {
        newApiVersion(completion: { newVersion, error in
            if newVersion {
                self.downloadCityData(completion: { success, error in
                    completion(success, error)
                })
            } else {
                completion(true, error)
            }
        })
    }
    
    private func downloadCityData(completion: @escaping (Bool, Error?) -> Void) {
        let webService = WebService()
        webService.getCitiesList(completion: { data, error in
            if let data = data {
                do {
                    self.cityModels = try CityJSONParser.listToModel(data)
                    DataManager.shared.save(cities: self.cityModels)
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            } else if let error = error {
                completion(false, error)
            }
        })
    }
    
    private func newApiVersion(completion: @escaping (Bool, Error?) -> Void) {
        let webService = WebService()
        webService.getDataVersion(completion: { data, error in
            if let versionData = data {
                do {
                    let version = try VersionJSONParser.parseVersion(versionData)
                    var userData = UserData()
                    if userData.version == version {
                        completion(false, nil)
                    } else {
                        userData.version = version
                        completion(true, nil)
                    }
                } catch {
                    completion(false, error)
                }
            }
        })
    }
    
    public func openCityDetails(for indexPath: IndexPath, completion: @escaping (CityModel?, Error?) -> ()) {
        guard let model = getMedia(forIndexPath: indexPath) else {
            completion(nil, MediaError.emptyData)
            return
        }
        
        if model.didCheckDetails {
            completion(model, nil)
        } else {
            self.vc?.openLoadingScreen()
            let webService = WebService()
            webService.getCityDetails(id: model.id, completion: { data, error in
                if let cityData = data {
                    do {
                        let parsedData = try CityJSONParser.detailsToModel(cityData)
                        model.update(data: parsedData)
                        DataManager.shared.update(city: model)
                        completion(model, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, MediaError.dataParsingError)
                }
            })
        }
    }
    
    // MARK: Private functions
    
    private func getMedia(forIndexPath indexPath: IndexPath) -> CityModel? {
        guard indexPath.row < cityModels.count else { return nil }
        return cityModels[indexPath.row]
    }
 }
