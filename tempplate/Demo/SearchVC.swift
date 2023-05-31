//
//  ViewController.swift
//  RxProject
//
//  Created by isoftstone on 2023/5/19.
//

import UIKit
import RxSwift
import FDLibrary

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        viewModel.songs.bind(to: tableView.rx.items(cellIdentifier: "SongsCell", cellType: SearchCell.self)) { (rows, songs, cell) in
            cell.textLabel?.text = "\(songs.name ?? "") - \(songs.artists.first?.name ?? "")"
        }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.size.width, height: view.bounds.height - 88), style: .plain)
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SongsCell")
        return tableView
    }()
    
    lazy var searchBar: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 44))
        textField.placeholder = "请输入歌曲名"
        return textField
    }()


}

