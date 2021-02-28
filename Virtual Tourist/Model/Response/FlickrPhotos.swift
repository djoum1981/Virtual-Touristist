// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flickrPhotos = try? newJSONDecoder().decode(FlickrPhotos.self, from: jsonData)

import Foundation

// MARK: - FlickrPhotos
struct FlickrPhotos: Codable {
    let photos: Photos
    let stat: String
}
