import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool 
//    var title:String
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        self.isChecked.toggle()
                        
                    }
//                Text(title)
            }
        }
        .foregroundColor(isChecked ? .blue : .black)
    }
}

//struct CheckboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckboxView()
//    }
//}
