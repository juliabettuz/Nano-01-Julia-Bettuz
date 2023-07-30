import SwiftUI

struct StackCardView: View {
    @ObservedObject var cardViewModel: CardViewModel
    @State private var offset: CGFloat = 0
    @State private var isDraggingRight = false
    @State private var isDraggingLeft = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                // Showing Next two cards at top like a Stack...
                VStack {
                    ZStack {
                        updateCard(size: size)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .offset(x: offset)
                .rotationEffect(.init(degrees: getRotation(angle: 8)))
                .contentShape(Rectangle().trim(from: 0, to: 1))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let translation = value.translation.width
                            offset = translation
                            
                            if translation > 0 {
                                isDraggingRight = true
                                isDraggingLeft = false
                                
                            } else if translation < 0 {
                                isDraggingLeft = true
                                isDraggingRight = false
                            }
                            
                        })
                        .onEnded({ value in
                            isDraggingRight = false
                            isDraggingLeft = false
                            let width = UIScreen.main.bounds.width - 50
                            let translation = value.translation.width
                            let checkingStatus = (translation > 0 ? translation : -translation)
                            withAnimation(.easeIn) {
                                if checkingStatus > (width / 2) {
                                    offset = (translation > 0 ? width : -width) * 2
                                    
                                    if translation > 0 {
                                        cardViewModel.rightSwipe()
                                        
                                    } else {
                                        cardViewModel.leftSwipe()
                                    }
                                } else {
                                    offset = .zero
                                }
                            }
                            
                            // Reset the offset to zero after the animation is done
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    offset = .zero
                                }
                            }
                        })
                )
                .onChange(of: cardViewModel.current) { _ in
                    // Reset the offset to zero when the current card changes
                    offset = .zero
                }
                
            }
            VStack {
                
//                if (cardViewModel.current.leftChoice == nil && cardViewModel.current.rightChoice == nil) {
                    if cardViewModel.current.currentCard == .impossible {
                        Button {
                            showAlert = true
                        } label: {
                            Text("It's impossible to choose")
                                .padding(.top, 24)
                              
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("You always have a choice"), message: Text("According to Sartre, lying to yourself by saying there's no choice is bad faith."), dismissButton: .default(Text("Make a decision")))
                        }
                    }
                        
//                    } else {
//                        Button {
//                            //
//                        } label: {
//                            Text("Continue")
//                                .padding(.top,24)
//
//                            //modifiers text button
//                        }
//                    }
//                                    }
                }
//            .padding(.top, 24)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        private func updateCard(size: CGSize) -> some View {
            VStack {
                ZStack {
                    if cardViewModel.current.cardColor == .black {
                        
                        Rectangle()
                            .fill(Color(UIColor.black))
                            .cornerRadius(16)
                            .shadow(radius: 4)
                            .frame(width: 331, height: 571)
                    } else {
                        Rectangle()
                            .fill(Color(UIColor.systemGray5))
                            .cornerRadius(16)
                            .shadow(radius: 4)
                            .frame(width: 331, height: 571)
                    }
                    
                    VStack {
                        if cardViewModel.current.cardColor == .black {
                            Text(cardViewModel.current.text)
                                .font(.body)
                                .foregroundColor(Color(UIColor.systemGray5))
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the available space within the card
                                .multilineTextAlignment(.leading)
                                .padding()
                        } else {
                            Text(cardViewModel.current.text)
                                .font(.body)
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the available space within the card
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                        
                        Spacer()
                        
                        HStack {
                            if let leftButton = cardViewModel.current.leftChoice {
                                if cardViewModel.current.cardColor == .black {
                                    Text(leftButton.textChoice)
                                        .foregroundColor(Color(UIColor.systemGray5))
                                        .padding()
                                        .padding(.bottom)
                                        .multilineTextAlignment(.center)
                                        .opacity(isDraggingLeft ? 1.0 : 0.0)
                                } else {
                                    Text(leftButton.textChoice)
                                        .padding()
                                        .padding(.bottom)
                                        .multilineTextAlignment(.center)
                                        .opacity(isDraggingLeft ? 1.0 : 0.0)
                                }
                                
                            }
                            
                            Spacer()
                            
                            if let rightButton = cardViewModel.current.rightChoice {
                                if cardViewModel.current.cardColor == .black  {
                                    Text(rightButton.textChoice)
                                        .foregroundColor(Color(UIColor.systemGray5))
                                        .padding()
                                        .padding(.bottom)
                                        .multilineTextAlignment(.center)
                                        .opacity(isDraggingRight ? 1.0 : 0.0)
                                } else {
                                    Text(rightButton.textChoice)
                                        .padding()
                                        .padding(.bottom)
                                        .multilineTextAlignment(.center)
                                        .opacity(isDraggingRight ? 1.0 : 0.0)
                                }
                                
                            }
                        }
                    }
                    .padding(16)
                    
                } .padding()
                
                Spacer()
            }
        }
        
        
        
        private func getRotation(angle: Double) -> Double {
            let rotation = (offset / (UIScreen.main.bounds.width - 50)) * angle
            return rotation
        }
    }

