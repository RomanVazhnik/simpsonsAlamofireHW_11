//
//  CharacterViewController.swift
//  simpsonsApi
//
//  Created by Роман Важник on 22/08/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit
import Alamofire

class CharacterViewController: UIViewController {
    
    @IBOutlet var quote: UILabel!
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterName: UILabel!
    
    @IBOutlet var imageActivity: UIActivityIndicatorView!
    
    @IBOutlet var showButton: UIButton!
    
    let url = "https://thesimpsonsquoteapi.glitch.me/quotes"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quote.text = ""
        characterName.text = ""
        
        showButtonSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
        imageActivity.startAnimating()
        imageActivity.hidesWhenStopped = true
        
    }
    
    @IBAction func nextCharacterButton() {
        imageActivity.isHidden = false
        imageActivity.startAnimating()
        fetchData()
    }
    
    private func fetchData() {
        guard let url = URL(string: url) else { return }
        request(url).validate().responseJSON { (responsJson) in
            switch responsJson.result {
            case .success(let jsonObject):
                let character = Character.getCharacter(from: jsonObject)
                
                guard
                    let imageStringURL = character?.image,
                    let imageURL = URL(string: imageStringURL),
                    let characterImageData = try? Data(contentsOf: imageURL)
                    else { return }
                
                DispatchQueue.main.async {
                    self.characterImage.image = UIImage(data: characterImageData)
                    self.quote.text = character?.quote
                    self.characterName.text = character?.character
                    self.imageActivity.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showButtonSetup() {
        showButton.layer.cornerRadius = 15
        showButton.layer.borderWidth = 6
        showButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
    }
    
    
}
