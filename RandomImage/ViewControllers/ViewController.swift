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
        URLSession.shared.dataTask(with: url) {
 data,
 response,
 error in
            guard let data,
                  let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async { [unowned self] in
                    setupUnavailableConfig(
                        UIContentUnavailableConfiguration.empty(),
                        with: "Network error or empty data"
                    )
                }
                return
            }
            
            DispatchQueue.main.async {[unowned self] in
                contentUnavailableConfiguration = nil
                
                switch response.statusCode {
                case 200:
                    guard let image = UIImage(data: data) else {
                        setupUnavailableConfig(.empty(), with: "Decoding error")
                        return
                    }
                    imageView.image = image
                    
                case 403:
                    setupUnavailableConfig(.search(), with: "403: No Result")
                case 404:
                    setupUnavailableConfig(.empty(), with: "404: Page not found")
                default:
                    setupUnavailableConfig(
                        .empty(),
                        with: "Unknown error: \(response.statusCode)"
                    )
                }
            }
        }.resume()
    }
}

