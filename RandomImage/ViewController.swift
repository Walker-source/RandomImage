//
//  ViewController.swift
//  RandomImage
//
//  Created by Denis Lachikhin on 01.04.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
    }

    @IBAction func updateImageDidPressed() {
    }

}

