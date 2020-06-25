//
//  ViewController.swift
//  Preglife
//
//  Created by Michał Krupa on 13/03/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit 

class MainViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let vm = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupRefreshControl()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationItem.title = vm.navigationTitle
    }
    
    private func setupViewModel() {
        vm.vc = self
        vm.checkForData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: vm.emptyCellNib, bundle: nil), forCellReuseIdentifier: vm.emptyCellIdentifier)
        tableView.register(UINib(nibName: vm.mediaCellNib, bundle: nil), forCellReuseIdentifier: vm.mediaCellIdentifier)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.layoutIfNeeded()
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pullRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func pullRefresh(_ sender: Any) {
        vm.getMediaData(completion: { [weak self] success, error in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                if success {
                    self?.tableView.reloadData()
                }
                if error != nil {
                    self?.coordinator?.showError(error!)
                }
            }
        })
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if vm.emptyTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.emptyCellIdentifier) as! EmptyTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.mediaCellIdentifier, for: indexPath) as! CityCell
            if let vm = vm.viewModel(indexPath) {
                cell.setup(vm)
            }
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard vm.emptyTable == false else { return }
        vm.openCityDetails(for: indexPath, completion: { [weak self] data, error in
            self?.hideLoadingScreen()
            if let cityData = data {
                self?.coordinator?.openCity(cityData)
            } else if let errorInfo = error {
                self?.coordinator?.showError(errorInfo)
            }
        })
    }
}
