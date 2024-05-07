//
//  SplashScreen.swift
//  ebay-app
//
//  Created by Parth Patel on 11/13/23.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        HStack{
            Spacer()
            Text("Powered By")
                .bold()
            Image("ebay")
                .resizable()
                .frame(width: 120,height: 50)
                .scaledToFit()
            Spacer()
        }
    }
}

#Preview {
    SplashScreen()
}
