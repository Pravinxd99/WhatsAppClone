//
//  BubbleImageView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 12/02/25.
//

import SwiftUI

struct BubbleImageView: View {
    var message : MessageItem
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            if message.direction == .sent {Spacer()}
            if message.showGroupPartnerInfo {
                CircularProfileImageView(profileImage: message.sender?.profileImage, size: .small)
                    .offset(y:-27)
            }
              imageVideo()
                .shadow(color: Color(.systemGray3).opacity(0.1),radius: 5,x:0 ,y: 20)
                    .overlay {
                        playButton()
                            .opacity( message.messageType == .video ? 1 :0)
                    }
               
                
            
            if message.direction == .received {Spacer()}
            
        }
        .frame(maxWidth: .infinity , alignment: message.alignment)
        .padding(.leading , message.leadingPadding)
        .padding(.trailing , message.trailingPadding)
        .padding(10)
    }
    
    private func playButton () -> some View  {
        Image(systemName: "play.fill")
            .padding()
            .imageScale(.large)
            .background(.thinMaterial)
            .foregroundStyle(.gray)
            .clipShape(Circle())
            
    }
    private func timeStampWithTick () -> some View {
            HStack {
                Text("12:00 AM")
                    .font(.caption  )
                if message.direction == .sent{
                    Image(.seen)
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 15 , height: 15)
                }
            }
        }

    private func shareButton () -> some View {
        
        Image(systemName: "arrowshape.turn.up.right.fill")
            .frame(width: 30 , height: 30)
            .foregroundStyle(.white)
            .background(.gray)
            .clipShape(Circle())
    }
    private func imageVideo () -> some View {
        VStack(alignment: .leading , spacing: 0) {
            Image(.stubImage0)
                .resizable()
                .scaledToFill()
                .frame(width: 250 , height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .background{RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(.systemGray5))}
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color(.systemGray5))
                )
                .padding(5)
                .overlay(alignment: .bottomTrailing) {
                    timeStampWithTick()
                        .padding(.vertical , 7)
                        .padding(.trailing)
                }
            if !message.message.isEmptyOrWhiteSpaces {
                Text(message.message)
                    .padding([.horizontal ,.bottom] ,8)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .frame(width: 220)
            }
        }
        .background(message.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .attachTail(direction: message.direction)
        
    }
}

#Preview {
    BubbleImageView(message: .sentMessageItem )
}





