import SwiftUI

struct ListRowView: View {
    
    @State var item : ItemModel
    let dateFormatter = DateFormatter()
    
    var body: some View {
        HStack {
            Image(systemName: item.isComplited ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color.accentColor)
                .font(.title)
                .onTapGesture {
                    withAnimation(.linear){
                        item.Compeletion()
                    }
                }
            VStack (alignment: .leading, spacing: 8){
                Text(item.title)
                    .font(.title3)
                Text(item.text)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor.secondaryLabel
                    ))
                HStack(spacing: 0){
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(Color(#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)))
                        Text(convertDateFormat(inputDate: item.dateToDo))
                    }
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "flag.fill")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)))
                        Text(convertDateFormat(inputDate: item.deadline))
                    }
                }
                .font(.subheadline)
            }
            
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
    
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "1", text: "1423423545645654645645654654645645456", dateToDo: "122", deadline: "122", isComplited: false)
    
    static var previews: some View {
        ListRowView(item: item1)
        
    }
}
