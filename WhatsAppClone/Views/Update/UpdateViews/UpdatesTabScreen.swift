//
//  UpdatesTabScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct UpdatesTabScreen: View {
    @State var searchText : String = ""
    var body: some View {
        NavigationStack {
            List {
                StatusView()
                    .listRowBackground(Color.clear)
                MyStatus()
                Section {
                    RecentUpdates()
                }header: {
                    Text("Recent updates")
                }
                Section {
                    ChannelListView()
                }header: {
                    channelHeaderView()
                }
                
                
            }
            .listStyle(.grouped)
            .navigationTitle("Updates")
            .searchable(text:$searchText )
        }
    }
        
       
       func channelHeaderView () -> some View {
           HStack {
               Text("Channels")
                   .bold()
                   .font(.headline)
                   .textCase(nil)
                   .foregroundStyle(.black)
                  
               Spacer()
               Button {
                   
               }
               label: {
                   Image(systemName: "plus")
                      .padding(7)
                       .background(Color(.systemGray5))
                       .clipShape(Circle())
                       
               }
           }
        }
    }



private struct StatusView : View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "circle.dashed")
                .imageScale(.large)
                .foregroundStyle(.blue)
            
            (
                Text("Use Status to share photos, text and videos that disappear in 24 hours.")
                +
                Text(" ")
                +
                Text("Status Privacy")
                    .foregroundStyle(.blue)
            )
            Button() {
                
            }
            label : {
                Image(systemName: "xmark")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10 , style: .continuous))
    }
}
private struct MyStatus :View {
    var body: some View {
        HStack {
            
            Circle()
                .frame(width: MyStatus.sizeOfCircles.size , height: MyStatus.sizeOfCircles.size)
            VStack(alignment: .leading){
                Text("My Status")
                    .bold()
                Text("Add to my status")
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            cameraButton()
            pencilButton()
        }
    }
    
    private func cameraButton () -> some View {
        Button () {
            
        }
        label : {
            Image(systemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .bold()
        }
    }
    private func pencilButton () -> some View {
        Button{
            
        }
        label : {
            Image(systemName: "pencil")
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .bold()
        }
    }
}
private struct RecentUpdates : View {
    var body: some View {
        
        HStack {
            
            Circle()
                .frame(width: MyStatus.sizeOfCircles.size , height: MyStatus.sizeOfCircles.size)
            VStack(alignment: .leading){
                Text("Joseph Smith")
                    .bold()
                Text("1hr ago")
                    .foregroundStyle(.gray)
            }
        }
    }
}

extension MyStatus {
    
    enum sizeOfCircles {
        static let size : CGFloat = 60
        
    }
    
}
private struct ChannelListView : View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stay updated on topics that matter to you. Find channels to follow below.")
                .foregroundStyle(.gray)
                .padding(.horizontal)
            ScrollView(.horizontal , showsIndicators: false){
                HStack{
                    ForEach(0..<5) { _ in
                        ChannelItemView()
                        
                    }
                }
            }
            .padding(10)
            Button {
                
            }
        label : {
            Text("Explore more")
                .frame(width: 120 , height: 40)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(Capsule())
                .padding(.leading)
                    }
        }
    }
}

private struct ChannelItemView : View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 50 , height: 50)
            Text("Real Madrid F.C")
            Button {
                
            }
            label : {
                Text("Follow")
            }
            .frame(maxWidth: .infinity)
            .bold()
            .padding(3)
            .background(.blue.opacity(0.7))
            .clipShape(Capsule())
           
        }
        .padding(.horizontal , 10)
        .padding(.vertical)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray), lineWidth: 1)
        }
    }
}
#Preview {
    UpdatesTabScreen()
}
