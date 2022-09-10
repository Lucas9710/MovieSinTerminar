//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Lucas on 11/08/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
   let services = MovieListService()
    
    
   let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        services.getMovies{ movies in
            print(movies)
            }onError: { error in
                print(error)
        }
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "cell \(indexPath.row + 1)"
        return cell
    }
}

