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
    
    static let sampleUserInstances : [UserItem] = [
        UserItem(uid : "uid1", username: "Praveen1", email: "sashapraveen1@gmail.com"),
        UserItem(uid : "uid2", username: "Praveen2", email: "sashapraveen2@gmail.com"),
        UserItem(uid : "uid3", username: "Praveen3", email: "sashapraveen3@gmail.com"),
        UserItem(uid : "uid4", username: "Praveen4", email: "sashapraveen4@gmail.com"),
        UserItem(uid : "uid5", username: "Praveen5", email: "sashapraveen5@gmail.com"),
        UserItem(uid : "uid6", username: "Praveen6", email: "sashapraveen6@gmail.com"),
        UserItem(uid : "uid7", username: "Praveen7", email: "sashapraveen7@gmail.com"),
        UserItem(uid : "uid8", username: "Praveen8", email: "sashapraveen8@gmail.com"),
        UserItem(uid : "uid9", username: "Praveen9", email: "sashapraveen9@gmail.com"),
        UserItem(uid : "uid10",username:"Praveen10", email: "sashapraveen10 @gmail.com"),
    ]
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

