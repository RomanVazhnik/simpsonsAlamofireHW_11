//
//  Character .swift
//  simpsonsApi
//
//  Created by Роман Важник on 22/08/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let quote: String?
    let character: String?
    let image: String?
    
    init (character: [String: Any]) {
        quote = character["quote"] as? String
        self.character = character["character"] as? String
        image = character["image"] as? String
    }
    
    static func getCharacter(from jsonData: Any) -> Character? {
        guard let jsonData = jsonData as? [[String: Any]] else { return nil }
        return Character(character: jsonData.first!)
    }
    
}

