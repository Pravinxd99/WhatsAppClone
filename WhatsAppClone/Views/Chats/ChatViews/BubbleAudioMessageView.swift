//
//  BubbleAudioMessageView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI

struct BubbleAudioMessageView: View {
    var message : MessageItem
    @State var sliderValue : Double = 0
    @State var sliderRange : ClosedRange<Double> = 0...20
    var body: some View {
        HStack(alignment: .bottom, spacing: 5){
            if message.showGroupPartnerInfo {
                CircularProfileImageView(profileImage: message.sender?.profileImage, size: .small)
                    
            }
            playButton()
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(5)
                .background(message.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
                .attachTail(direction: message.direction)
                .padding(5)
                .frame(maxWidth: .infinity , alignment: message.alignment)
                .padding(.leading , message.direction == .received ? 5 :100)
                .padding(.trailing , message.direction == .received ? 100 : 5)
            
            
            timeStampWithTick()
            
        }
    }
    private func timeStampWithTick () -> some View {
        HStack{
            Text("3:05 AM")
                .font(.caption)
               
            
            if message.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
             
        }
        .padding(.leading)
        .padding(.trailing)
        
        }

    private func playButton () -> some View {
        HStack {
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15 , height: 15)
                .padding()
                .background(message.direction == .sent ? .white : .green)
                .foregroundStyle(message.direction == .sent ? .black : .white)
                .clipShape(Circle())
            slider()
            duration()
        }
        .padding(4)
    }
    private func slider () -> some View {
        Slider(value: $sliderValue , in: sliderRange)
            .tint(.gray)
            .foregroundStyle(.gray)
    }
    private func duration() -> some View {
        Text("00:06")
    }
}

#Preview {
    ZStack {
        Color(.systemGray3)
        BubbleAudioMessageView(message: .sentMessageItem)
    }
    .ignoresSafeArea()
  
        
    
}
