import SwiftUI
import Alamofire
import SwiftyJSON
import Kingfisher

struct FavouritesView: View {
//     var favourites:[FavouritedItem] = []
    @EnvironmentObject private var listViewModel: ListDataViewModel
    @EnvironmentObject var viewModel: ItemDetailsViewModel
    @State private var showingToast = false
    @State private var toastMessage = ""
    @State private var isLoading=true

    
    var body: some View {
        var totalPrice: Float {
            var ans:Float=0
            for item in listViewModel.favouritedItems{
                ans+=Float(item.price)!
            }
            return ans
            }
        if(isLoading){
            HStack{
                Spacer()
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        // Simulate loading by adding a delay
                        //                                                self.isLoading=true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isLoading = false
                            
                        }
                    }
                Spacer()
            }
            
        }
        else{
            VStack {
                    if listViewModel.favouritedItems.count==0 {
                        HStack{
                            Spacer()
                            Text("No items in wishlist")
                            Spacer()
                        }
                    }
                    if listViewModel.favouritedItems.count>0 {
                        List() {
                            HStack{
                                Text("Wishlist total(\(listViewModel.favouritedItems.count)) items:")
                                
                                Spacer()
                                Text("$\(String(format: "%.2f", totalPrice))")
                                
                            }
                            ForEach(listViewModel.favouritedItems, id: \.id){product in
                                HStack{
                                    Spacer()
                                    VStack{
                                        KFImage(URL(string: product.img))
                                            .resizable()
                                        //                                        .aspectRatio(contentMode: .fit)
                                            .frame(width:60, height: 80)
                                            .cornerRadius(8)
                                    }
                                    VStack(alignment: .leading){
                                        Text(product.title)
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .padding(.leading,10)
                                        Text("$"+product.price)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                            .padding(.leading,10)
                                            .bold()
                                        
                                        if product.shipping=="0.0"{
                                            Text("Free Shipping")
                                                .foregroundColor(.secondary)
                                                .padding(.leading,12)
                                        }else{
                                            Text(product.shipping)
                                                .foregroundColor(.secondary)
                                                .padding(.leading,12)
                                        }
                                        HStack{
                                            
                                            VStack{
                                                Text(product.location)
                                                    .foregroundColor(.secondary)
                                                //                                                .padding(.leading,10)
                                            }
                                            Spacer()
                                            VStack{
                                                Text(product.condition)
                                                    .foregroundColor(.secondary)
                                                //                                                .padding(.leading,20)
                                            }
                                        }
                                        .padding(.leading,15)
                                        
                                    }
                                    
                                }
                            }
                            .onDelete(perform: deleteFromWishlist)
                        }
                    }
                
                }
            .navigationTitle("Favorites")
        }
    }
    func deleteFromWishlist(at offsets: IndexSet) {
        for index in offsets {
            let productId = listViewModel.favouritedItems[index].id
//            print("product to be deleted:",listViewModel.favouritedItems[index])
            listViewModel.removeFromWishlist(productId: productId)
            listViewModel.favouritedItems.remove(at: index)
            
        }
    }
    
//        func removeFromWishlist(productId: String) {
//        let baseURL = "http://localhost:3000/removeFromWishList"
//        let queryParams = "productId=\(productId)"
//        
//        let apiUrl = "\(baseURL)?\(queryParams)"
//        
//         AF.request(apiUrl,method: .get)
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    listViewModel.favoritedProductIds.removeAll{$0 == productId}
//                    let json = JSON(data)
//                    print("item deleted response:",json)
//                    
//                case .failure(let error):
//                    print("API request failed: \(error)")
//                }
//            }
////            objectWillChange.send()
//    }
}
