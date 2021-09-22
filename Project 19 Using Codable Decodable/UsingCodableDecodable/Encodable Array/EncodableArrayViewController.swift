//
//  EncodableArrayViewController.swift
//  UsingCodableDecodable
//
//  Created by HuyPQ22 on 2021/09/03.
//  Copyright © 2021 exlinct. All rights reserved.
//
// https://stackoverflow.com/questions/44441223/encode-decode-array-of-types-conforming-to-protocol-with-jsonencoder

import UIKit

class EncodableArrayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        do {
            let article = Article(tags: tags.map(AnyTag.init), title: "Article Title")

            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted

            let jsonData = try jsonEncoder.encode(article)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print(error)
        }
        
        let jsonData =
        """
        {
          "title" : "Article Title",
          "tags" : [
            {
              "type" : "author",
              "value" : "Author Tag Value"
            },
            {
              "type" : "genre",
              "value" : "Genre Tag Value"
            }
          ]
        }
        """.data(using: .utf8)!
        
        do {
            let decoded = try JSONDecoder().decode(Article.self, from: jsonData)

            print(decoded)
        } catch {
            print(error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol Tag: Codable {
    var type: String { get }
    var value: String { get }
}

struct AuthorTag: Tag {
    var type = "author"
    let value: String
}

struct GenreTag: Tag {
    var type = "genre"
    let value: String
}

struct AnyTag : Tag, Codable {

    let type: String
    let value: String

    init(_ base: Tag) {
        self.type = base.type
        self.value = base.value
    }
}

struct Article: Codable {
    let tags: [AnyTag]
    let title: String
}

let tags: [Tag] = [
    AuthorTag(value: "Author Tag Value"),
    GenreTag(value:"Genre Tag Value")
]
