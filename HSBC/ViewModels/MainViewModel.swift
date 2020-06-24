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
    
    private var cityModels: [CityModel] = []
    private var mediaProcessing: Bool = false
    
    var processingCoreData: Bool {
        return mediaProcessing
    }
    
    public var emptyTable: Bool {
        return cityModels.isEmpty
    }
    
    public var numberOfElements: Int {
        return cityModels.count
    }
    
    // MARK: Public functions
    
    public func checkForData() {
//        if let mediaEntities = MediaCoreDataManager.shared.fetchMediaArray() {
//            self.mediaProcessing = true
//            self.delegate?.startFetchControllerIndicator()
//            createModels(fromEntites: mediaEntities).then { models in
//                self.getAdditionalData(for: models)
//            }
//        }
    }
    
    public func changeFavorite(atIndexPath indexPath: IndexPath) {
//        let media = getMedia(forIndexPath: indexPath)
//        media.favorite = !media.favorite
//        MediaCoreDataManager.shared.setMedia(favorite: media.favorite, title: media.title, type: media.type.rawValue)
    }
    
    public func viewModel(_ indexPath: IndexPath) -> CityCellViewModel? {
        guard let model = getMedia(forIndexPath: indexPath) else { return nil }
        return CityCellViewModel(city: model)
    }
    
    public func getMediaUrl(forIndexPath indexPath: IndexPath) -> URL? {
//        guard indexPath.section < mediaModels.count else { return nil }
//        guard indexPath.row < mediaModels[indexPath.section].count else { return nil }
//        return mediaModels[indexPath.section][indexPath.row].mediaUrl
        return nil
    }
    
    public func getMediaData(completion: @escaping (Bool, Error?) -> Void) {
        let webService = WebService()
        webService.getCitiesData(completion: { data, error in
            if let data = data {
                do {
                    self.cityModels = try CityJSONParser.parseToModel(data)
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            } else if let error = error {
                completion(false, error)
            }
        })
    }
    
    public func openMedia(forIndexPath indexPath: IndexPath) {
//        let model = getMedia(forIndexPath: indexPath)
//        if !model.isShown {
//            model.isShown = true
//            MediaCoreDataManager.shared.setMediaIsShown(title: model.title, type: model.type.rawValue)
//            delegate?.reloadCellAt(indexPath)
//        }
//        WebService().pingGithub()
//        delegate?.openMediaFrom(url: model.mediaUrl, type: model.type)
    }
    
    // MARK: Private functions
    
    private func createModels(fromJSON json: [Data], completion: @escaping([CityModel]) -> Void) {
//        return Promise { seal in
//            do {
//                let mediaModels = try JSONParser.toMediaModel(json)
//                MediaCoreDataManager.shared.createMedia(mediaModels)
//                seal.fulfill(mediaModels)
//            } catch {
//                seal.reject(MediaError.jsonParsingError)
//            }
//        }
    }
    
    private func createModels(fromEntites entites: [City], completion: @escaping ([CityModel]) -> Void)  {
//        return Promise { seal in
//            do {
//                let mediaModels = try entites.compactMap({ try MediaModel($0) })
//                seal.fulfill(mediaModels)
//            } catch {
//                seal.reject(MediaError.unknownError)
//            }
//        }
    }
    
    private func getAdditionalData(for models: [CityModel], completion: @escaping () -> Void) {
//        let urls = models.compactMap({ return $0.thumbUrl })
//        return Promise { seal in
//            firstly {
//                WebService().getThumbImages(from: urls)
//            }.done { images in
//                self.bind(media: models, images: images)
//            }.ensure {
//                self.delegate?.mediaDownloaded(success: true)
//            }.catch { error in
//                self.delegate?.mediaDownloaded(success: false)
//                self.delegate?.show(alert: self.createErrorAlert(message: AlertMessages.corruptedData.rawValue))
//            }
//        }
    }
    
    private func bind(media: [CityModel], images: [(image: UIImage,url: URL)]) {
//        mediaModels.removeAll()
//        for model in media {
//            if let thumbImage = images.filter({ $0.url == model.thumbUrl }).first?.image {
//                model.image = thumbImage
//            }
//        }
//        for type in MediaType.allCases.sorted(by: { $0.rawValue > $1.rawValue }) {
//            var modelGroups = media.filter({ $0.type == type })
//            modelGroups.sort(by: { $0.title.localizedStandardCompare($1.title) == .orderedAscending })
//            self.mediaModels.append(modelGroups)
//        }
//        self.mediaProcessing = false
    }
    
    private func createErrorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ups!", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        
        return alert
    }
    
    private func getMedia(forIndexPath indexPath: IndexPath) -> CityModel? {
        guard indexPath.row < cityModels.count else { return nil }
        return cityModels[indexPath.row]
    }
    
 }
