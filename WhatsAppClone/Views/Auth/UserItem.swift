//
//  Untitled.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 17/02/25.
//

struct UserItem :  Identifiable , Hashable , Decodable {
    
    let uid : String
    let username : String
    //let password :String
    var bio : String? = nil
    var profileImage : String? = nil
    var email : String
    var bioUnwrapped : String {
        return bio ?? "Hey there I am using Whatsapp."
    }
    var id: String {
        return uid
    }
    
    init(uid: String, username: String, bio: String? = nil, profileImage: String? = nil, email: String) {
        self.uid = uid
        self.username = username
        self.bio = bio
        self.profileImage = profileImage
        self.email = email
    }
    
}
struct sampleUserItem {
    static let sampleUserInstance = UserItem(uid : "uid", username: "Praveen", email: "sashapraveen@gmail.com")
}

extension UserItem {
    
    init(dictionary : [String : Any]) {
        self.uid = dictionary[.uid] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.bio = dictionary[.bio] as? String? ?? nil
        self.profileImage = dictionary[.profileImage] as? String? ?? nil
        
    }
    
}
extension String {
    static let uid = "uid"
    static let username = "username"
    static let bio = "bio"
    static let profileImage = "profileImage"
    static let email = "email"
    
}

