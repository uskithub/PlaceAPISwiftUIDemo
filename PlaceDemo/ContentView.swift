//
//  ContentView.swift
//  PlaceDemo
//
//  Created by 斉藤 祐輔 on 2022/03/16.
//

import SwiftUI
import Combine
import GoogleMapsPlatformCombine
import GooglePlaces

struct ContentView: View {
    @State var place: String = ""
    @StateObject private var presenter = Presenter()
    
    // https://sarunw.com/posts/searchable-in-swiftui/
    var body: some View {
        NavigationView {
            VStack {
                List(presenter.predictions) { place in
                    Text(place.title)
                }
            }.searchable(
                text: $place
                , prompt:"検索したい場所を入力します"
                , suggestions: {
                    ForEach(presenter.predictions) { prediction in
                        Text(prediction.title)
                            .searchCompletion(prediction.title)
                    }
                }
            )
                .onChange(of: place, perform: { newValue in
                    presenter.search(text: newValue)
                })
                .navigationTitle("Places")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
