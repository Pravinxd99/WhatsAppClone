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
                    .offset(y:2)
                
            }
            if message.direction == .sent {
                timeStampWithTick()
            }
            HStack {
                playButton()
                Slider(value: $sliderValue , in: sliderRange)
                    .tint(.gray)
                Text("04:00")
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
            .padding(5)
            .background(message.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
            
            .attachTail(direction: message.direction)
            if message.direction == .received {
                timeStampWithTick()
            }
        }.padding()
                .frame(maxWidth: .infinity , alignment: message.alignment)
                .padding(.leading , message.leadingPadding)
                .padding(.trailing , message.trailingPadding)
            
        }
    
    private func timeStampWithTick () -> some View {
            Text("3:05 AM")
                .font(.footnote)
                .foregroundStyle(.gray)
        }

    private func playButton () -> some View {
        Button {
            
        }label: {
            Image(systemName: "play.fill")
                .padding(10)
                .background(message.direction == .received ? .green : .white)
                .clipShape(Circle())
                .foregroundStyle(message.direction == .received ? .white : .black)
            
        }
       
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
        VStack{
            BubbleAudioMessageView(message: .sentMessageItem)
            BubbleAudioMessageView(message: .receivedMessageItem)
        }
    }
    .ignoresSafeArea()
  
        
    
}
