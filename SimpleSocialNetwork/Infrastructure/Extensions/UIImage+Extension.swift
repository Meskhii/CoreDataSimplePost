//
//  UIImage+Extension.swift
//  SimpleSocialNetwork
//
//  Created by user200328 on 6/18/21.
//

import UIKit

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }
    var png: Data? { pngData() }
}
