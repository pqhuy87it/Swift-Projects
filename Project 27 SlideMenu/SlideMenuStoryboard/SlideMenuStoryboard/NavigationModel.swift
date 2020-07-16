//
//  NavigationModel.swift
//  SlideMenuStoryboard
//
//  Created by mybkhn on 2020/07/16.
//  Copyright © 2020 exlinct. All rights reserved.
//

import Foundation

protocol NavigationDelegate{
	func navigation(didSelect: NavigationModel?)
}

protocol SidebarDelegate {
	func sidbarDidOpen()
	func sidebarDidClose()
	func sidebarDidClose(with item: NavigationModel?)
}

enum NavigationTypes{
	case home,star,about,facebook,instagram
}

struct NavigationModel {
	let name: String
	let type: NavigationTypes
}
