//
//  XCTestCase+helpers.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/30/21.
//

import Foundation
import XCTest

public extension XCTestCase {

    // MARK: Helpers

    func getPath(forResource: String, ofType: String) -> String {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: forResource,
                                         ofType: ofType)
            else { fatalError("Can't find " + forResource + " resource file") }
        return path
    }

    func getApiResourceJson(withPath: String) throws -> [String: Any] {
        let apiResponseData = try Data(contentsOf: URL(fileURLWithPath: withPath))
        let apiResponseJson = try JSONSerialization.jsonObject(with: apiResponseData,
                                                                   options: []) as? [String: Any]
        return apiResponseJson!
    }

    func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://PLACEHODLER")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)
    }

    enum TestError: Error {
        case testError
    }

    // MARK: JSON

    func badJsonData() -> Data {
        """
        {{{}
        """.data(using: .utf8)!
    }

    // swiftlint:disable all
    // disabled due to length warning on igotPath value
    func teamJsonData() -> Data {
    """
    {
        "_internal": {
            "pubDateTime":"2020-11-17 10:30:16.813 EST",
            "igorPath":
                "cron,1605627010823,1605627010823|router,1605627010823,1605627010828|domUpdater,1605627011040,1605627016242|feedProducer,1605627016447,1605627017092",
            "xslt":"NBA/xsl/league/roster/marty_teams_list.xsl",
            "xsltForceRecompile":"true",
            "xsltInCache":"true",
            "xsltCompileTimeMillis":"335",
            "xsltTransformTimeMillis":"238","consolidatedDomKey":"prod__transform__marty_teams_list__1929228391129",
            "endToEndTimeMillis":"6269"
        },
        "league":{
            "standard": [
                {
                    "isNBAFranchise":true,
                    "isAllStar":false,
                    "city":"Atlanta",
                    "altCityName":"Atlanta",
                    "fullName":"Atlanta Hawks",
                    "tricode":"ATL",
                    "teamId":"1610612737",
                    "nickname":"Hawks",
                    "urlName":"hawks",
                    "teamShortName":"Atlanta",
                    "confName":"East",
                    "divName":"Southeast"
                }
            ]
        }
    }

    """.data(using: .utf8)!
    }
    // swiftlint:enable all
}
