//
//  ebay_appApp.swift
//  ebay-app
//
//  Created by Parth Patel on 11/8/23.
//

import SwiftUI

@main
struct ebay_appApp: App {
    @StateObject private var viewModel = ItemDetailsViewModel()
    @StateObject private var listViewModel = ListDataViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                
                ContentView()
            }
            .toast(isShowing: $viewModel.showToast, text: Text(viewModel.toastMessage))
            .environmentObject(viewModel)
            .environmentObject(listViewModel)
        }
    }
}
