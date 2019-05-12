//
//  MediaViewController.swift
//  TopTop
//
//  Created by Oriontek iOS on 5/12/19.
//  Copyright © 2019 com.jhonny.learning. All rights reserved.
//

import Foundation
import UIKit

class MediaViewController: UIViewController {
    
    var mediaTableView: UITableView!
    var navigationBar: UINavigationBar!
    var customNavigationItem: UINavigationItem!
    var segmentedControl: UISegmentedControl!
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        setUpView()
    }
    
    private func setUpView() {
        prepareSegmentedControl()
        
        navigationBar = UINavigationBar(frame: view.frame)
        navigationBar.delegate = self
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        customNavigationItem = UINavigationItem()
        customNavigationItem.titleView = segmentedControl
        
        navigationBar.setItems([customNavigationItem], animated: true)
        view.addSubview(navigationBar)
        
        let topConstraint = navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        let leadingConstraint = navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor)
        let trailingConstraint = navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        
        prepareTableView()
    }
    
    private func prepareSegmentedControl() {
        segmentedControl = UISegmentedControl(frame: view.frame)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        segmentedControl.insertSegment(withTitle: "Movies", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Playlists", at: 1, animated: true)
        
        segmentedControl.tintColor = .purple
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func prepareTableView() {
        mediaTableView = UITableView(frame: view.frame, style: .plain)
        mediaTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mediaTableView)
        
        let topConstraint = mediaTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        let leadingConstraint = mediaTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
        let trailingConstraint = mediaTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        let bottomConstraint = mediaTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraint
        ])
        
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MediaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UIBarPositioningDelegate, UINavigationBarDelegate
extension MediaViewController: UIBarPositioningDelegate, UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
