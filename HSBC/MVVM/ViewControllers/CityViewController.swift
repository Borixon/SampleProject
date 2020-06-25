//
//  CityViewController.swift
//  HSBC
//
//  Created by Michał Krupa on 23/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class CityViewController: BaseViewController {

    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var vm = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: vm.commonCellIdentifier)
        tableView.register(UINib(nibName: vm.headerNibName, bundle: nil), forCellReuseIdentifier: vm.headerCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

    func updateViewModel(cityModel: CityModel) {
        vm.model = cityModel
    }
    
    @IBAction func checkOnMap(_ sender: Any) {
        coordinator?.showCity(geolocation: vm.coordinates)
    }
}

extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CityHeaderCell.height
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.rowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.headerCellIdentifier) as! CityHeaderCell
            let data: (String, String, UIImage?) = vm.dataFor(indexPath: indexPath)
            cell.setup(title: data.0, detailText: data.1, image: data.2)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.commonCellIdentifier)!
            let text: String = vm.dataFor(indexPath: indexPath)
            cell.textLabel?.text = text
            cell.prepareForCityView()
            return cell
        }
    }
}
