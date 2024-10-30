import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView().frame(height: 300)
        CircleImage()
            .offset(y: -130)
            .padding(.bottom, -130)
        VStack (alignment: .leading) {
            Text("그리핀도르 Gryffindor").font(.title)
            HStack {
                Image("Hogwarts")
                Text("  호그와트 Hogwarts")
                Spacer()
                Text("United Kingdom")
            }.font(.subheadline)
                .foregroundStyle(.gray)
            
            Divider()
            Text("About Gryffindor")
            Text("Descriptive text goes here")
        }.padding()
        Spacer()
    }
}

#Preview {
    ContentView()
}
