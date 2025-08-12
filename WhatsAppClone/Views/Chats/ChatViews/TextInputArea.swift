//
//  TextInputArea.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct TextInputArea: View {
    @Binding var enteredText : String
    
    private var buttonEnabler : Bool {
        
        enteredText.isEmptyOrWhiteSpaces
    }
    
    var onSent : () -> Void
    var body: some View {
        HStack (alignment: .bottom, spacing: 5){
            Button {
                
            }
            label: {Image(systemName: "photo.on.rectangle")
                    .padding(3)
                    .font(.title3)
                    .font(.system(size: 30))
            }
            
            Button {
                
            }
            label: {
                Image(systemName: "mic.fill")
                        .fontWeight(.heavy)
                        .imageScale(.small)
                        .foregroundStyle(.white)
                        .padding(6)
                        .background(Color(.blue))
                        .clipShape(Circle())
                        .padding(.horizontal,3)
                        
            }
            TextField("", text: $enteredText , axis: .vertical)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous) .fill(.thinMaterial))
                .overlay {
                    borderProvider()
                        
                }
            uploadButton()
                .disabled(buttonEnabler)
                .grayscale (buttonEnabler ? 0.8 : 0.2)
        }
        .padding(.bottom)
        .padding(.horizontal , 8)
        .padding(.top , 10)
        .background(.whatsAppWhite)
    }
    
    @ViewBuilder
    private func borderProvider () -> some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(Color(.systemGray5),lineWidth: 1)
    }
    @ViewBuilder
    private func uploadButton () -> some View {
        Button {
            
            onSent()
        }
        label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .imageScale(.small)
                    .frame(width: 30 , height: 30)
                    .foregroundStyle(.white)
                    .background(Color(.blue))
                    .clipShape(Circle())
                    .padding(.horizontal,3)
                    .padding(.leading , 1)
                    .padding(.vertical , 2)
        }
    }
}

#Preview {
    TextInputArea(enteredText: .constant("")){
        
    }
    
}
