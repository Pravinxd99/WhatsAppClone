//
//  CircularProfileImageView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 01/10/25.
//

import SwiftUI
import Kingfisher
struct CircularProfileImageView: View {
    var profileImageUrl : String?
    var size : Size
    var fallbackImage : FallBackImage
    init(profileImage: String? = nil , size: Size) {
        self.profileImageUrl = profileImage
        self.size = size
        self.fallbackImage = .directchannelImage
    }
    var body: some View {
        if let image = profileImageUrl {
            KFImage(URL(string: image))
                .resizable()
                .placeholder({ProgressView() })
                .scaledToFill()
                .frame(width: size.dimension , height: size.dimension)
                .clipShape(Circle())
        }
        else {
            placeHolderView()
        }
    }
    private func placeHolderView () -> some View {
        Image(systemName: fallbackImage.rawValue)
            .resizable()
            .scaledToFill()
            .imageScale(.large)
            .foregroundStyle(Color.placeholder)
            .frame(width: size.dimension , height: size.dimension)
            .background(Color.white)
            .clipShape(Circle())
    }
}
   
extension CircularProfileImageView {
    enum  Size {
        case mini , small , xsmall , medium , large , xlarge
        case custom (size : CGFloat)
        
        var dimension : CGFloat {
            switch self {
            case .mini:
                return 20
            case .small:
                return 30
            case .xsmall:
                return 40
            case .medium:
                return 60
            case .large:
                return 80
            case .xlarge:
                return 100
            case .custom (let size):
                return size
            }
        }
    }
    enum FallBackImage : String {
        case directchannelImage = "person.circle.fill"
        case groupchannelImage = "person.2.circle.fill"
        
        init(for membersCount : Int) {
            switch membersCount {
            case 2 :
                self = .directchannelImage
            default :
                self = .groupchannelImage
                
            }
        }
    }
}
extension CircularProfileImageView {
    init(_ channel : ChannelItem , size : Size ) {
        self.profileImageUrl = channel.coverImageUrl
        self.size = size
        self.fallbackImage = FallBackImage(for: channel.membersCount)
    }
}
#Preview {
    CircularProfileImageView( size: .large )
}
