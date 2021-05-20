import SwiftUI

struct ListRowView: View {
    
    let item : ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isComplited ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color.accentColor)
                .font(.title2)
            VStack (alignment: .leading, spacing: 8){
                Text(item.title)
                    .font(.title2)
                Text(item.text)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor.secondaryLabel
                    ))
                HStack(spacing: 2){
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(Color.accentColor)
                        Text(item.dateToDo)
                    }
                        
                    Spacer()
                    
                    HStack{
                        Image(systemName: "flag.fill")
                            .foregroundColor(Color.accentColor)
                        Text(item.deadline)
                    }
                }
                .font(.headline)
            }
//            Spacer()
                
            
            
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
    
    func correctDateOutPut(item : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        
        return dateFormatter.date(from: item)!
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "1", text: "1423423545645654645645654654645645456", dateToDo: "122", deadline: "122", isComplited: false)
    
    static var previews: some View {
        ListRowView(item: item1)
        
    }
}
