//
//  HomeViewController.swift
//  Avito_testTask
//
//  Created by Arina on 24.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    typealias ViewModel = HomeViewModel
    private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.fetchAdvertisements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Collection Ext
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewState.value?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: indexPath) as! HomeCollectionViewCell
        
        guard let item = viewModel.viewState.value?.data?[indexPath.row] else { return cell }
        cell.configure(with: item)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 30) / 2
        return CGSize(width: cellWidth, height: 250)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.viewState.value?.data?[indexPath.row] else { return }
        let detailViewController = DetailViewController(detailId: item.id)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - HomeViewController Ext
private extension HomeViewController {
    func setUp() {
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        viewModel.viewState.bind { state in
            switch state {
            case .loading:
                self.showActivityIndicator()
            case .loaded:
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.collectionView.reloadData()
                }
                break
            case .error:
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.title = state?.message
                }
            default: break
            }
        }
    }
    
    func setUpContraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showActivityIndicator() {
        spinner = UIActivityIndicatorView(style: .large)
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    func hideActivityIndicator(){
        spinner.stopAnimating()
    }
}

