import SwiftUI

struct ContentView: View {
    @State var startScreen = true
    
    var body: some View {
        
        if startScreen{
            SplashScreen()
                .onAppear
                    {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1){self.startScreen = false }
                    }
                
        }
        else{
            ProductSearchView()
        }
    }
}

#Preview {
    ContentView()
}
