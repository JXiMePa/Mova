//
//  ViewController.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import UIKit
import RealmSwift

final class SearchImageViewController: UIViewController {
    
    //MARK: Views
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = ConstName.searchPlaceholder
        search.returnKeyType = .search
        search.enablesReturnKeyAutomatically = true
        search.delegate = self
        return search
    }()
    
    private lazy var resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250.0
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
        return tableView
    }()
    
    //MARK: Property
    private let realm = try! Realm()
    private var items: Results<RealmModel>!
    private var searchText = ""
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupView()
        checkInternet()
    }
    
    //MARK: Func
    private func checkInternet() {
        if !Reachability.isConnectedToNetwork() {
            Alert.showAlert(title: ConstName.internetTitle + "?", msg: ConstName.errorMessage, customActions: []) { [weak self] (alert) in
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .blue
        resultTableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.identifier)
        items = realm.objects(RealmModel.self)
    }
    
    private func addViews() {
        //searchBar
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
        //resultTableView
        view.addSubview(resultTableView)
        _ = resultTableView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
}

//MERK: UISearchBarDelegate
extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
            searchBar.text = ""
            
            ApiService.shered.getImageBy(name: text) { [weak self] (model) in
                
                if let photos = model?.photos, photos.count != 0 {
                    
                    guard let `self` = self,
                        let imageString = model?.photos?.first?.imageSize?.landscape else { return }
                    
                    DispatchQueue.main.async {
                        let modelObject = RealmModel()
                        modelObject.searchText = self.searchText
                        modelObject.imageString = imageString
                        
                        do {
                            try self.realm.write {
                                self.realm.add([modelObject])
                            }
                            self.resultTableView.reloadData()
                        } catch let error {
                            print(error)
                            Alert.showAlert(title: "Error!", msg: ConstName.errorMessage, customActions: []) { [weak self] (alert) in
                                self?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                } else {
                    Alert.showAlert(title: "🔍", msg: ConstName.emptyResult, customActions: [], completion: { [weak self] (alert) in
                        self?.present(alert, animated: true, completion: nil)
                    })
                }
            }
        }
    }
}

//MARK: TableViewDelegate, TableViewDataSource
extension SearchImageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: ResultCell.identifier, for: indexPath) as! ResultCell
        let item = items.reversed()[indexPath.row]
        cell.setText = item.searchText
        cell.setImage = item.imageString
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let editingRow = items[indexPath.row]
            
            do {
                try self.realm.write {
                    self.realm.delete(editingRow)
                    resultTableView.deleteRows(at: [indexPath], with: .automatic)
                }
                
            } catch let error {
                print(error)
                Alert.showAlert(title: "Error!", msg: ConstName.errorMessage, customActions: []) { [weak self] (alert) in
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
