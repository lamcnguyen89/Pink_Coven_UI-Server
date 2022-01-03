//
//  ImageRoutes.swift
//  Application
//
//  Created by Lam Nguyen on 1/3/22.
//

import Foundation
import Kitura

func initializeImageRoutes(app: App) throws {
    let fileServer = try setupFileServer()
    app.router.get("/api/v1/images", middleware: fileServer)
    app.router.post("/api/v1/image") {
        request, response, next in
        defer { next() }
        
        guard let filename = request.headers["Slug"] else {
            response.status(preconditionFailed).send("Filename not specified")
            return
        }
        var imageData = Data()
        do {
            try _ = request.read(into: &imageData)
        } catch let readError {
            response.status(.internalServerError).send("Unable to read image data: \(readError.localizedDescription)")
            return
        }
        do {
            let fullPath = "\(fileServer.absoluteRootPath) /\(filename)"
            let fileUrl = URL(fileURLWithPath: fullPath)
            try imageData.write(to: fileUrl)
            response.status(.created).send("Image created")
        } catch let writeError {
            response.status(.internalServerError).send("Unable to write image Data: \(writeError.localizedDescription)")
            return
        }
    }
}

private func setupFileServer() throws -> StaticFileServer {
    let cacheOptions = StaticFileServer.CacheOptions(maxCachedControlHeader: 3600)
    let options = StaticFileServer.Options(cacheOptions: cacheOptions)
    let fileServer = StaticFileServer(path: "images", options: options)
    try FileManager.default.createDirectory(at: fileServer.absoluteRootPath, withIntermediateDirectories: true, attributes: nil)
    return fileServer
}
