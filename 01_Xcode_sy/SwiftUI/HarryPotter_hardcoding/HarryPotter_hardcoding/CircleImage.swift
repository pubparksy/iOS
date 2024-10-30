import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("Gryffindor")
            .clipShape(.circle)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
    
}

#Preview {
    CircleImage()
}
