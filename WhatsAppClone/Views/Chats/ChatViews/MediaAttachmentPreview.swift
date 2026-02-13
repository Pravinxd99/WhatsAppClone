//
//  MediaAttachmentPreview.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 05/01/26.
//

import SwiftUI

struct MediaAttachmentPreview: View {
    let mediaAttachment : [MediaAttachment]
    var body: some View {
        ScrollView(.horizontal , showsIndicators: false) {
            HStack {
                //audioAttachmentPreview()
                ForEach(mediaAttachment) { attachment in
                    thumbnailImageView(attachment)
                }
            }.padding()
        } .frame(height: Constants.listHeight)
            .frame(maxWidth: .infinity)
            .background(.whatsAppWhite)
    }
    @ViewBuilder
    private func thumbnailImageView (_ attachment : MediaAttachment) -> some View {
        Button {
            
        }label: {
            Image(uiImage: attachment.thumbNail)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageDimen , height: Constants.imageDimen)
                .cornerRadius(5)
                .clipped()
                .overlay(content: {
                    playButton("play.fill")
                        .opacity(attachment.type == .video(UIImage(), .stubUrl) ? 1 : 0)
                })
                .overlay(alignment: .topTrailing) {
                    cancelButton()
                }
        }
        
    }
    private func cancelButton () -> some View {
        Button {
              
        }label: {
            Image(systemName: "xmark")
                .scaledToFill()
                .imageScale(.small)
                .frame(width:8 , height: 8)
                .padding(5)
                .foregroundStyle(.whatsAppWhite)
                .background(Color(.white).opacity(0.5))
                .clipShape(Circle())
                .padding(2)
                .bold()
                
        }
    }
    private func audioAttachmentPreview () -> some View {
        ZStack {
            LinearGradient(colors: [.green , .green.opacity(0.7) , .teal], startPoint: .topLeading, endPoint: .bottom)
            
            playButton("mic.fill")
                .padding(.bottom , 15)
                
        }
        .frame(width: Constants.imageDimen*2 , height: Constants.imageDimen)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .clipped()
        .overlay(alignment: .topTrailing) {
            cancelButton()
        }
        .overlay(alignment: .bottomLeading) {
            Text("this is the name of the audio file")
                .lineLimit(1)
                .font(.caption)
                .padding(2)
                .frame(maxWidth: .infinity , alignment: .center)
                .foregroundStyle(.white)
                .background(Color.white.opacity(0.5))
                
                
        }
    }
    private func playButton (_ systemName : String) -> some View {
        Button {
              
        }label: {
            Image(systemName: systemName)
                .scaledToFill()
                .imageScale(.large)
                .frame(width:40 , height:30)
                .padding(5)
                .foregroundStyle(.whatsAppWhite)
                .background(Color(.white).opacity(0.5))
                .clipShape(Circle())
                .padding(2)
                .bold()
                
        }
    }
}

extension MediaAttachmentPreview {
    enum Constants {
        static let listHeight : CGFloat = 100
        static let imageDimen : CGFloat = 80
    }
}
#Preview {
    MediaAttachmentPreview(mediaAttachment: [])
}
