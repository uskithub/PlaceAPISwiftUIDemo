//
//  ContentView2.swift
//  PlaceDemo
//
//  Created by 斉藤 祐輔 on 2022/03/16.
//

import SwiftUI
import Combine
import GoogleMapsPlatformCombine
import GooglePlaces

// https://stackoverflow.com/questions/62176306/swiftui-example-for-autocompletion

struct ContentView2: View {
    @State var place: String = ""
    @StateObject private var presenter = Presenter()
    
    var body: some View {
        
        VStack {
            TextField(
                "検索したい場所を入力します"
                , text: self.$place
                , onEditingChanged: { isEditing in
                    if isEditing { presenter.enable() }
                }
            )
                .onChange(of: self.place) { newValue in
                    presenter.search(text: newValue)
                }

            List(presenter.predictions) { place in
                Text(place.title)
                    .onTapGesture {
                        self.place = place.title
                        presenter.disable()
                    }
            }

        }.padding()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
