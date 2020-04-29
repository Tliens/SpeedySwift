//
//  FileManagerExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von. Carreos on 05/02/2018.
//  Copyright © 2018 SpeedySwift
//

#if canImport(Foundation)
import Foundation

public extension FileManager {

    /// 从给定路径的JSON文件中读取
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - options: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    public func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

        return json as? [String: Any]
    }

    /// 从具有给定文件名的JSON文件中读取。
    ///
    /// - Parameters:
    ///   - filename: File to read.
    ///   - bundleClass: Bundle where the file is associated.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    public func jsonFromFile(
        withFilename filename: String,
        at bundleClass: AnyClass? = nil,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift

        // To handle cases that provided filename has an extension
        let name = filename.components(separatedBy: ".")[0]
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main

        if let path = bundle.path(forResource: name, ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

            return json as? [String: Any]
        }

        return nil
    }

}
#endif
