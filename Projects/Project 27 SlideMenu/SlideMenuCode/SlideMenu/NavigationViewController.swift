//
//  NavigationViewController.swift
//  SlideMenu
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationDelegate{
	func navigation(didSelect: NavigationModel?)
}

enum NavigationTypes{
	case home,star,about,facebook,instagram
}

struct NavigationModel {
	let name: String
	let type: NavigationTypes
}

class NavigationViewController: UIViewController{

	var myView: NavigationView {return view as! NavigationView}
	unowned var collectionView: UICollectionView {return myView.collectionView}
	var delegate: NavigationDelegate?
	var list = [NavigationModel]()

	override func loadView() {
		view = NavigationView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupList()
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	func setupList(){
		list.append(NavigationModel(name: "Home", type: .home))
		list.append(NavigationModel(name: "Star", type: .star))
		list.append(NavigationModel(name: "About", type: .about))
		list.append(NavigationModel(name: "Facebook", type: .facebook))
		list.append(NavigationModel(name: "Instagram", type: .instagram))
	}
}


extension NavigationViewController: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return list.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigationCell", for: indexPath) as! NavigationCell
		let model = list[indexPath.item]
		cell.label.text = model.name
		return cell
	}
}

extension NavigationViewController: UICollectionViewDelegate{

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.navigation(didSelect: list[indexPath.item])
	}
}

extension NavigationViewController: UICollectionViewDelegateFlowLayout{
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 45)
	}
}
