//
//  ViewController.swift
//  RandomImage
//
//  Created by Denis Lachikhin on 01.04.2025.
//

import UIKit

enum Link {
    case imageURL
    
    var link: URL {
        switch self {
        case .imageURL:
            URL(string: "https://picsum.photos/200/300")!
        }
    }
}

final class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage(with: Link.imageURL.link)
        setupUnavailableConfig(
            UIContentUnavailableConfiguration.loading(),
            with: "Loading image"
        )
    }
    
    // MARK: - IB Actions
    @IBAction private func updateImageDidPressed() {
        setupUnavailableConfig(
            UIContentUnavailableConfiguration.loading(),
            with: "Loading image"
        )
        fetchImage(with: Link.imageURL.link)
    }
    
    // MARK: - Private Methods
    private func setupUnavailableConfig(
        _ unavailableCOnfiguration: UIContentUnavailableConfiguration,
        with title: String
    ) {
        imageView.image = nil
        var config = unavailableCOnfiguration
        config.text = title
        config.textProperties.font = .boldSystemFont(ofSize: 20)
        contentUnavailableConfiguration = config
    }
}


// MARK: - Networking
private extension ViewController {
    private func fetchImage(with url: URL) {
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
}

