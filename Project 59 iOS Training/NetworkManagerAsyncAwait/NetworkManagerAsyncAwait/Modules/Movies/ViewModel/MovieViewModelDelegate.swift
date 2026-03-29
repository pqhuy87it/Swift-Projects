//
//  MovieViewModelDelegate.swift
//  NetworkManagerAsyncAwait
//
//  Created by Huy Pham on 2024/10/31.
//

import Foundation

protocol MovieViewModelDelegate: BaseViewModelDelegate {
    func getDataMoviesSuccess()
    func handleGetMoviesFailedWith(_ error: NetworkError)
}
