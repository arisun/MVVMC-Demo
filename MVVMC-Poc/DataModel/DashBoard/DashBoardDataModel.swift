

import Foundation
import ObjectMapper

struct DashBoardDataModel : Mappable {
	var status : String?
	var source : String?
	var sortBy : String?
	var articles : [Articles]?

	init?(map: Map) {
        mapping(map: map)
	}

	mutating func mapping(map: Map) {

		status <- map["status"]
		source <- map["source"]
		sortBy <- map["sortBy"]
		articles <- map["articles"]
	}

}
