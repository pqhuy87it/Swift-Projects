//
//  User.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class User: Codable {
    var id: Int
    var name: String
    var email: String
    var username: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
    init(id: Int, name: String, email: String, username: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

class Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipode: String
    var geo: Geo
    
    init(street: String, suite: String, city: String, zipode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipode = zipode
        self.geo = geo
    }
}

class Geo: Codable {
    var lat: Double
    var lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

class Company: Codable {
    var name: String
    var cachPhrase: String
    var bs: String
    
    init(name: String, cachPhrase: String, bs: String) {
        self.name = name
        self.cachPhrase = cachPhrase
        self.bs = bs
    }
}
