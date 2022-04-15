//
//  UserDefaults.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import Foundation

extension UserDefaults {
    
    enum Key: String {
        
        case introDidSkip = "introDidSkip"
        
    }
    
    func bool(key: UserDefaults.Key) -> Bool {
        self.bool(forKey: key.rawValue)
    }
    
    func setValue(_ value: Any?, key: UserDefaults.Key) {
        self.setValue(value, forKey: key.rawValue)
    }
    
    func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            print("\(#function) - UserDefault set 실패")
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
        guard let data = data(forKey: forKey) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            return nil
        }
    }
}
