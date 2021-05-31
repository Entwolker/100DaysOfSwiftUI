//
//  CardView.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import SwiftUI

struct CardView: View {
    
    let card: Card
    
    @State private var showingAnswer = false
    @State private var offset = CGSize.zero
    
    var removal: (() -> Void)? = nil
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white.opacity(1 - Double(abs(offset.width / 50))))
                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(offset.width > 0 ? Color.green : Color.red))
                
                VStack {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if showingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .padding()
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .frame(width: geo.size.width)
            .offset(x: offset.width * 1.5)
            .opacity(4 - Double(abs(offset.width / 50)))
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        self.offset = gesture.translation
                        self.feedback.prepare()
                    }
                    .onEnded { _ in
                        if abs(self.offset.width) > 100 {
                            if self.offset.width > 100 {
                                self.feedback.notificationOccurred(.success)
                            } else {
                                self.feedback.notificationOccurred(.error)
                            }
                            
                            self.removal?()
                        } else {
                            withAnimation {
                                self.offset = .zero
                            }
                        }
                    }
            )
            .aspectRatio(1.4, contentMode: .fit)
            .shadow(radius: 10)
            .onTapGesture(perform: {
                self.showingAnswer = true
            })
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(.fixed(width: 400, height: 285.714285714))
        
    }
}
