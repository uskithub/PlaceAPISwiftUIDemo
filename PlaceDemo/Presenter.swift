//
//  Presenter.swift
//  PlaceDemo
//
//  Created by 斉藤 祐輔 on 2022/03/16.
//

import Foundation
import Combine
import GoogleMapsPlatformCombine
import GooglePlaces


struct Place : Identifiable {
    var id: String { placeId }
    let placeId: String
    let title: String
}

class Presenter: ObservableObject {
    
    @Published var predictions = [Place]()
    private var isAutocompleteAvailable = false
    private var token: GMSAutocompleteSessionToken?
    private var cancellables = [AnyCancellable]()
    
    func enable() {
        self.token = GMSAutocompleteSessionToken()
        self.isAutocompleteAvailable = true
    }
    
    func disable() {
        self.isAutocompleteAvailable = false
        self.predictions = [Place]()
        self.token = nil
    }
    
    func search(text: String) {
        guard isAutocompleteAvailable else { return }

        GMSPlacesClient.shared().findAutocompletePredictions(
            from: text
            , filter: nil
            , sessionToken: self.token
        )
            .sink { completion in
                if case .finished = completion {
                    print("findAutocompletePredictions は正常終了")
                } else if case .failure(let error) = completion {
                    print("findAutocompletePredictions が異常終了: \(error)")
                }
            } receiveValue: { predictions in
                
                self.predictions = predictions.map { prediction in
                    print(prediction)
                    return Place(placeId: prediction.placeID, title: prediction.attributedFullText.string)
                }
            }
            .store(in: &cancellables)

    }
}
