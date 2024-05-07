//
//  Toast.swift
//  ebay-app
//
//  Created by Parth Patel on 11/9/23.
//

import SwiftUI


struct Toast<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let text: Text
    let delay:TimeInterval=1.5

    var body: some View {
        if self.isShowing{
            DispatchQueue.main.asyncAfter(deadline: .now()+self.delay){
                withAnimation{
                    self.isShowing=false
                }
            }
        }
        return GeometryReader { geometry in

            ZStack(alignment: .bottom) {

                self.presenting()
                    .blur(radius: self.isShowing ? 1 : 0)

                VStack {
                    self.text
                }
                .frame(width: 350,
                       height: 80)
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)

            }

        }

    }

}

extension View {

    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }

}
