//
//  NukeProxy.swift
//  NukeProxy
//
//  Created by Drastic Actions on 21/11/2020.
//  Copyright © 2022 Drastic Actions. All rights reserved.
//

import Foundation
import Nuke
import NukeExtensions

#if !os(macOS)
import UIKit
public typealias CrossPlatformImage = UIImage
public typealias CrossPlatformImageView = UIImageView
#else
import AppKit
public typealias CrossPlatformImage = NSImage
public typealias CrossPlatformImageView = NSImageView
#endif

@objc(ImagePipeline)
public class ImagePipeline : NSObject {
    
    @objc
    public static let shared = ImagePipeline()
    
    @objc
    public func loadImage(url: URL, onCompleted: @escaping (CrossPlatformImage?, String) -> Void) {
        _ = Nuke.ImagePipeline.shared.loadImage(
            with: url,
            progress: nil,
            completion: { result in
                switch result {
                case let .success(response):
                    onCompleted(response.image, "success")
                case let .failure(error):
                    onCompleted(nil, error.localizedDescription)
                }
            }
        )
    }
    
    @objc
    @MainActor
    public func loadImage(url: URL, placeholder: CrossPlatformImage?, errorImage: CrossPlatformImage?, imageProxyTransition: ProxyTransitionOptions?, failedImageProxyTransition: ProxyTransitionOptions?, into: CrossPlatformImageView) {
        var imageTransition: ImageLoadingOptions.Transition? = nil
        var failedImageTransition: ImageLoadingOptions.Transition? = nil
        
        if imageProxyTransition != nil {
            imageTransition = generateTransitionOptions(options: imageProxyTransition!)
        }
        
        if failedImageProxyTransition != nil {
            failedImageTransition = generateTransitionOptions(options: failedImageProxyTransition!)
        }
        
        let options = ImageLoadingOptions(placeholder:placeholder, transition: imageTransition, failureImage: errorImage, failureImageTransition: failedImageTransition)
        
        NukeExtensions.loadImage(with: url, options: options, into: into)
    }
    
    @objc
    @MainActor
    public func loadImage(url: URL, imageIdKey: String, placeholder: CrossPlatformImage?, errorImage: CrossPlatformImage?, imageProxyTransition: ProxyTransitionOptions?, failedImageProxyTransition: ProxyTransitionOptions?, into: CrossPlatformImageView) {

        var imageTransition: ImageLoadingOptions.Transition? = nil
        var failedImageTransition: ImageLoadingOptions.Transition? = nil
        
        if imageProxyTransition != nil {
            imageTransition = generateTransitionOptions(options: imageProxyTransition!)
        }
        
        if failedImageProxyTransition != nil {
            failedImageTransition = generateTransitionOptions(options: failedImageProxyTransition!)
        }
        
        let options = ImageLoadingOptions(placeholder:placeholder, transition: imageTransition, failureImage: errorImage, failureImageTransition: failedImageTransition)
        
        NukeExtensions.loadImage(with: ImageRequest(
            url: url,
            userInfo: [.imageIdKey: imageIdKey]
        ), options: options, into: into)
    }
    
    @objc
    public func loadData(url: URL, onCompleted: @escaping (Data?, URLResponse?) -> Void) {
        loadData(url: url, imageIdKey: nil, reloadIgnoringCachedData: false, onCompleted: onCompleted)
    }
    
    @objc
    public func loadData(url: URL, imageIdKey: String?, reloadIgnoringCachedData: Bool, onCompleted: @escaping (Data?, URLResponse?) -> Void) {
        _ = Nuke.ImagePipeline.shared.loadData(
            with: ImageRequest(
                url: url,
                options: reloadIgnoringCachedData ? [.reloadIgnoringCachedData] : [],
                userInfo: [.imageIdKey: imageIdKey]
            ),
            completion: { result in
                switch result {
                case let .success(response):
                    onCompleted(response.data, response.response)
                case .failure(_):
                    onCompleted(nil, nil)
                }
            }
        )
    }
    
    func generateTransitionOptions(options: ProxyTransitionOptions) -> ImageLoadingOptions.Transition {
#if !os(macOS)
        switch options.styleTransition {
            case .fadeIn:
            if (options.options != nil)
            {
                return ImageLoadingOptions.Transition.fadeIn(duration: options.duration, options: options.options!)
            }
            else
            {
                return ImageLoadingOptions.Transition.fadeIn(duration: options.duration)
            }
        }
#else
        switch options.styleTransition {
            case .fadeIn:
            return ImageLoadingOptions.Transition.fadeIn(duration: options.duration)
        }
#endif
    }
}

@objc(ImageCache)
public final class ImageCache: NSObject {
    
    @objc
    public static let shared = ImageCache()
    
    @objc
    public func removeAll() {
        Nuke.ImageCache.shared.removeAll()
    }
}

@objc(DataLoader)
public final class DataLoader: NSObject {
    
    @objc
    public static let shared = DataLoader()
    
    @objc
    public func removeAllCachedResponses() {
        Nuke.DataLoader.sharedUrlCache.removeAllCachedResponses()
    }
}

@objc(Prefetcher)
public final class Prefetcher: NSObject {
 
    let prefetcher = ImagePrefetcher()
    
    @objc
    public func startPrefetching(with: [URL]) {
        prefetcher.startPrefetching(with: with)
    }
    
    @objc
    public func stopPrefetching(with: [URL]) {
        prefetcher.stopPrefetching(with: with)
    }
    
    @objc
    public func stopPrefetching() {
        prefetcher.stopPrefetching()
    }
    
    @objc
    public func pause() {
        prefetcher.isPaused = true
    }
    
    @objc
    public func unPause() {
        prefetcher.isPaused = false
    }
}

@objc(ProxyTransitionOptions)
public final class ProxyTransitionOptions: NSObject {
    var styleTransition: StyleTransition
    var duration: TimeInterval
#if !os(macOS)
    var options: UIView.AnimationOptions?
    
    @objc
    init(styleTransition: StyleTransition, duration: TimeInterval, options: UIView.AnimationOptions) {
        self.styleTransition = styleTransition
        self.duration = duration
        self.options = options
    }
    
    @objc
    init(styleTransition: StyleTransition, duration: TimeInterval) {
        self.styleTransition = styleTransition
        self.duration = duration
        self.options = UIView.AnimationOptions.allowUserInteraction
    }
    
    @objc
    public static func generate(styleTransition: StyleTransition, duration: TimeInterval, options: UIView.AnimationOptions) -> ProxyTransitionOptions
    {
        return ProxyTransitionOptions(styleTransition: styleTransition, duration: duration, options: options)
    }
    
#else
    @objc
    init(styleTransition: StyleTransition, duration: TimeInterval) {
        self.styleTransition = styleTransition
        self.duration = duration
    }
#endif
    
    @objc
    public static func generate(styleTransition: StyleTransition, duration: TimeInterval) -> ProxyTransitionOptions
    {
        return ProxyTransitionOptions(styleTransition: styleTransition, duration: duration)
    }
}

@objc(StyleTransition)
public enum StyleTransition : Int {
    case fadeIn
}
