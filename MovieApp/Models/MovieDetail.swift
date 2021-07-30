//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Prabakaran Kuppusamy on 30/07/21.
//

import Foundation

struct MovieDetail: Identifiable, Codable {
    
    var id : Int?
    var title: String?
    var budget: Int?
    var status:String?
    var path:String?
    var releaseDate: String?
    var runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case budget
        case status
        case path = "poster_path"
        case releaseDate = "release_date"
        case runtime
    }
    
    var url: String {
        "http://image.tmdb.org/t/p/" + "w300/" + (path ?? "")
    }
    
    var totalBudget: String? {
        budget?.createCurrencyString()
    }
    
    var movieTime: String?  {
        if let timeSec = runtime {
            let time = minutesToHoursAndMinutes(timeSec)
            return String(format: "%d:%d", time.hours,time.leftMinutes)
        }
        return nil
    }
    

    
    func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
}


extension Int {
    func createCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
