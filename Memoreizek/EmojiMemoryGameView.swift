//
//  ContentView.swift
//  Memoreizek
//
//  Created by Richard.ZHENG on 2021/1/25.
//

import SwiftUI
//var con: Int = 0

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        let color  = viewModel.theme.color
        let themeName = viewModel.theme.name
        
        let score = viewModel.score
        
        VStack{
            Text(themeName + ": \(score)")
            Grid(viewModel.cards){card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding()
//                .foregroundColor(Color(color))
            }
            Button(action: {viewModel.newGame()}){
                Text("New")
                    .font(.body)
                    .bold()
                    .padding()
                    .foregroundColor(.black)
                    
            }
            .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
            .cornerRadius(20)
            
            
//
        }
        
            
        
        .padding()
        .foregroundColor(Color(color))
        
    }
    
    
//    print(con)
}




struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
//    var viewModel: EmojiMemoryGame
    
    var body: some View{
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
       
    }
    
    func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(verbatim: card.content)
//                
            }else{
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
            
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    let cornerRadius:CGFloat = 10.0
    let edgeLineWidth:CGFloat = 3
    
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width,size.height)*0.75
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
