//
//  QuakesListViewController.swift
//  Twitter Quake
//
//  Created by AppStarter on 16.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import UIKit

final class QuakesListViewController: UIViewController {
    fileprivate struct Constants {
        static let segueIdentifier = "QuakeDetails"
    }
    
    fileprivate var earthQuakes: [Quake]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard earthQuakes == nil else { return }
        fetchEarthquakes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier, let quakeDetailsViewController = segue.destination as? QuakeDetailsViewController, let index = sender as? Int, let earthQuakes = earthQuakes {
            quakeDetailsViewController.quake = earthQuakes[index]
        }
    }
    
    private func fetchEarthquakes() {
        EarthquakeService.getEarthquakesAfter(numberOfDays: 2) { result in
            switch result {
            case .success(let earthquakesResult):
                self.earthQuakes = earthquakesResult.quakes
            case .error(_): ()
            }
        }
    }
}

extension QuakesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath.row)
    }
}

extension QuakesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthQuakes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let earthQuakes = earthQuakes else { return cell }
        cell.textLabel?.text = earthQuakes[indexPath.row].place
        return cell
    }
}

