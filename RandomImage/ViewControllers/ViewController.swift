//
//  ViewController.swift
//  RandomImage
//
//  Created by Denis Lachikhin on 01.04.2025.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - Private Properies
    private let url = URL(string: "https://picsum.photos/200/300")!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        setupUnavailableConfig()
    }
    
    // MARK: - IB Actions
    @IBAction private func updateImageDidPressed() {
        fetchImage()
    }
    
    // MARK: - Private Methods
    private func fetchImage() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                return
            }
            
            DispatchQueue.main.async {[weak self] in
                guard let self else { return }
                imageView.image = UIImage(data: data)
                contentUnavailableConfiguration = nil
            }
        }.resume()
    }
    private func setupUnavailableConfig() {
        var config = UIContentUnavailableConfiguration.loading()
        config.text = "Waiting for a response…"
        config.textProperties.font = .boldSystemFont(ofSize: 20)
        contentUnavailableConfiguration = config
    }
}

