
import SwiftUI
import Kingfisher
import Alamofire
import SwiftyJSON

struct ItemCard: View {
    
    @EnvironmentObject var viewModel: ItemDetailsViewModel
    @EnvironmentObject private var listViewModel: ListDataViewModel
    @State private var showingToast = false
    @State private var toastMessage = ""

    var product: Product
    func truncatedTitle(for title: String) -> String {
        if title.count > 20 {
            let endIndex = title.index(title.startIndex, offsetBy: 14)
            return String(title[..<endIndex]) + "..."
        } else {
            return title
        }
    }
    func addToWishlist(){
        let baseURL = "http://localhost:3000/addToWishList"
        let queryParams = "itemId=\(product.id)&imageUrl=\(product.img)&title=\(product.title)&price=\(product.price)&shippingOption=\(product.shipping)&condition=\(product.condition)&location=\(product.location)"
        
        let apiUrl = "\(baseURL)?\(queryParams)"
        
         AF.request(apiUrl,method: .get)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    print("item added response:",json)
                case .failure(let error):
                    print("API request failed: \(error)")
                }
            }
        
        
                   viewModel.toastMessage = "Added to favorites"
                   viewModel.showToast=true
               
    }
    func removeFromWishlist(){
        let baseURL = "http://localhost:3000/removeFromWishList"
        let queryParams = "productId=\(product.id)"
        
        let apiUrl = "\(baseURL)?\(queryParams)"
        
         AF.request(apiUrl,method: .get)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    print("item deleted response:",json)
                case .failure(let error):
                    print("API request failed: \(error)")
                }
            }
        
                   viewModel.toastMessage = "Removed from favorites"
                   viewModel.showToast = true
    }
    var body: some View {
            HStack{
                Spacer()
                VStack{
                    KFImage(URL(string: product.img))
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 80)
                        .cornerRadius(8)
                }
                VStack(alignment: .leading){
                    Text(product.title)
                        .lineLimit(1)
                        .font(.subheadline)
                        .padding(.leading,10)
                    Text("$"+product.price)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.leading,10)
                        .bold()
                    if(product.shipping=="0.0"){
                        Text("Free Shipping")
                            .foregroundColor(.secondary)
                            .padding(.leading,10)
                    }else{
                        Text("$"+product.shipping)
                            .foregroundColor(.secondary)
                            .padding(.leading,10)
                    }
                    
                    HStack{
                        
                        VStack{
                            Text(product.location)
                                .foregroundColor(.secondary)
                                .padding(.leading,10)
                        }
                        Spacer()
                        VStack{
                            if(product.condition==""){
                                Text("NA")
                            }else{
                                Text(product.condition)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }

                
                VStack{
                        Image(systemName: product.isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(maxWidth: 25,maxHeight:23)
                        .aspectRatio(contentMode: .fit)
                                               .onTapGesture {
                                                   let index=listViewModel.products.firstIndex(where: {$0.id==product.id})!
                                                   
                                                   if listViewModel.products[index].isFavorited == true{
                                                       removeFromWishlist()
                                                   }
                                                   if listViewModel.products[index].isFavorited == false{
                                                       addToWishlist()
                                                   }
                                                            
                                                   listViewModel.products[index].isFavorited.toggle()
                                                }
                }
//                .frame(width: 50,height: 50)
            }

            
    }
   
        
}

//struct ToastModifier: ViewModifier {
//    @Binding var isPresenting: Bool
//    var message: String
//
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//
//            if isPresenting {
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text(message)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black)
//                            .cornerRadius(10)
//                            .padding()
//                            .transition(.move(edge: .bottom))
//                    }
//                }
//                .edgesIgnoringSafeArea(.all) // Ensure the toast covers the entire screen
//            }
//        }
//    }
//}

