//
//  ViewController.swift
//  RandomImage
//
//  Created by Denis Lachikhin on 01.04.2025.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let url = URL(string: "https://picsum.photos/200/300")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    @IBAction private func updateImageDidPressed() {
        fetchImage()
    }
    
    private func fetchImage() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                return
            }
            
            DispatchQueue.main.async {[weak self] in
                guard let self else { return }
                imageView.image = UIImage(data: data)
                activityIndicator.stopAnimating()
            }
        }.resume()
    }
}

