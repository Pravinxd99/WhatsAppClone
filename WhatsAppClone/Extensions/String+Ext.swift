//
//  String_Ext.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 07/07/25.
//

import Foundation


extension String {
    
    var isEmptyOrWhiteSpaces : Bool{
        
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
