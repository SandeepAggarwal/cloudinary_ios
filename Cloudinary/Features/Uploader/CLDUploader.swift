//
//  CLDUploader.swift
//
//  Copyright (c) 2016 Cloudinary (http://cloudinary.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/**
 The CLDUploader class is used to upload assets to your Cloudinary account's cloud.
*/
@objc public class CLDUploader: CLDBaseNetworkObject {
    
    // MARK: - Init
    
    private override init() {
        super.init()
    }
    
    internal override init(networkCoordinator: CLDNetworkCoordinator) {
        super.init(networkCoordinator: networkCoordinator)
    }
    
    
    // MARK: - Actions
    
    /**
    Uploads the given data to the configured cloud.
    
    - parameter data:               The data to upload.
    - parameter params:             An object holding all the available parameters for uploading.
    - parameter progress:      The closure that is called periodically during the data transfer.
    - parameter completionHandler:  The closure to be called once the request has finished, holding either the response object or the error.
    
    - returns:                      An instance of `CLDUploadRequest`,
                                    allowing the options to add a progress closure that is called periodically during the upload
                                    and a response closure to be called once the upload is finished,
                                    as well as performing actions on the request, such as cancelling, suspending or resuming it.
    */
    public func upload(data data: NSData, params: CLDUploadRequestParams? = nil, progress: ((bytes: Int64, totalBytes: Int64, totalBytesExpected: Int64) -> ())? = nil, completionHandler:( (response: CLDUploadResult?, error: NSError?) -> ())? = nil) -> CLDUploadRequest {
        let params = params ?? CLDUploadRequestParams()
        params.setSigned(true)
        let request = networkCoordinator.upload(data, params: params)
        let uploadRequest = CLDUploadRequest(networkDataRequest: request)
        if let completionHandler = completionHandler {
            uploadRequest.response(completionHandler)
        }
        if let progress = progress {
            uploadRequest.progress(progress)
        }
        return uploadRequest
    }
    
    /**
     Uploads the given data to the configured cloud.
     
     - parameter data:              The data to upload.
     - parameter params:            An object holding all the available parameters for uploading.
     - parameter progress:     The closure that is called periodically during the data transfer.
     - parameter completionHandler: The closure to be called once the request has finished, holding either the response object or the error.
     
     - returns:                     An instance of `CLDUploadRequest`,
                                    allowing the options to add a progress closure that is called periodically during the upload
                                    and a response closure to be called once the upload is finished,
                                    as well as performing actions on the request, such as cancelling, suspending or resuming it.
     */
    public func unsignedUpload(data data: NSData, uploadPreset: String, params: CLDUploadRequestParams? = nil, progress: ((bytes: Int64, totalBytes: Int64, totalBytesExpected: Int64) -> ())? = nil, completionHandler:( (response: CLDUploadResult?, error: NSError?) -> ())? = nil) -> CLDUploadRequest {
        let params = params ?? CLDUploadRequestParams()
        params.setSigned(false)
        params.setUploadPreset(uploadPreset)
        return upload(data: data, params: params, progress: progress, completionHandler: completionHandler)
    }
    
     /**
     Uploads a file from the specified URL to the configured cloud.
     The URL can either be of a local file (i.e. from the bundle) or can point to a remote file.
     
     - parameter url:               The URL pointing to the file to upload.
     - parameter params:            An object holding all the available parameters for uploading.
     - parameter progress:     The closure that is called periodically during the data transfer.
     - parameter completionHandler: The closure to be called once the request has finished, holding either the response object or the error.
     
     - returns:                     An instance of `CLDUploadRequest`,
                                    allowing the options to add a progress closure that is called periodically during the upload
                                    and a response closure to be called once the upload is finished,
                                    as well as performing actions on the request, such as cancelling, suspending or resuming it.
     */
    public func upload(url url: NSURL, params: CLDUploadRequestParams? = nil, progress: ((bytes: Int64, totalBytes: Int64, totalBytesExpected: Int64) -> ())? = nil, completionHandler:( (response: CLDUploadResult?, error: NSError?) -> ())? = nil) -> CLDUploadRequest {
        let params = params ?? CLDUploadRequestParams()
        params.setSigned(true)
        let request = networkCoordinator.upload(url, params: params)
        let uploadRequest = CLDUploadRequest(networkDataRequest: request)
        if let completionHandler = completionHandler {
            uploadRequest.response(completionHandler)
        }
        if let progress = progress {
            uploadRequest.progress(progress)
        }
        return uploadRequest
    }
    
    /**
     Uploads a file from the specified URL to the configured cloud.
     The URL can either be of a local file (i.e. from the bundle) or can point to a remote file.
     
     - parameter url:               The URL pointing to the file to upload.
     - parameter params:            An object holding all the available parameters for uploading.
     - parameter progress:     The closure that is called periodically during the data transfer.
     - parameter completionHandler: The closure to be called once the request has finished, holding either the response object or the error.
     
     - returns:                     An instance of `CLDUploadRequest`,
                                    allowing the options to add a progress closure that is called periodically during the upload
                                    and a response closure to be called once the upload is finished,
                                    as well as performing actions on the request, such as cancelling, suspending or resuming it.
     */
    public func unsignedUpload(url url: NSURL, uploadPreset: String, params: CLDUploadRequestParams? = nil, progress: ((bytes: Int64, totalBytes: Int64, totalBytesExpected: Int64) -> ())? = nil, completionHandler:( (response: CLDUploadResult?, error: NSError?) -> ())? = nil) -> CLDUploadRequest {
        let params = params ?? CLDUploadRequestParams()
        params.setSigned(false)
        params.setUploadPreset(uploadPreset)
        return upload(url: url, params: params, progress: progress, completionHandler: completionHandler)
    }    

}