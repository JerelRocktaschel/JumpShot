//
//  XCTestCase+helpers.swift
//  JumpShotTests
//
//  Created by Jerel Rocktaschel on 3/30/21.
//

import Foundation
import XCTest
import UIKit

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
    
    func playerJsonData() -> Data {
    """
    {
       "_internal":{
          "pubDateTime":"2021-04-14 13:10:13.166 EDT",
          "igorPath":"S3,1618420200191,1618420202214|router,1618420202214,1618420202220|domUpdater,1618420202419,1618420212034|feedProducer,1618420212146,1618420219068",
          "xslt":"NBA/xsl/league/roster/marty_active_players2.xsl",
          "xsltForceRecompile":"true",
          "xsltInCache":"false",
          "xsltCompileTimeMillis":"236",
          "xsltTransformTimeMillis":"5747",
          "consolidatedDomKey":"prod__transform__marty_active_players2__396760168367",
          "endToEndTimeMillis":"18877"
       },
       "league":{
          "standard":[
             {
                "firstName":"Precious",
                "lastName":"Achiuwa",
                "temporaryDisplayName":"Achiuwa, Precious",
                "personId":"1630173",
                "teamId":"1610612748",
                "jersey":"5",
                "isActive":true,
                "pos":"F",
                "heightFeet":"6",
                "heightInches":"8",
                "heightMeters":"2.03",
                "weightPounds":"225",
                "weightKilograms":"102.1",
                "dateOfBirthUTC":"1999-09-19",
                "teams":[
                   {
                      "teamId":"1610612748",
                      "seasonStart":"2020",
                      "seasonEnd":"2020"
                   }
                ],
                "draft":{
                   "teamId":"1610612748",
                   "pickNum":"20",
                   "roundNum":"1",
                   "seasonYear":"2020"
                },
                "nbaDebutYear":"2020",
                "yearsPro":"0",
                "collegeName":"Memphis",
                "lastAffiliation":"Memphis/Nigeria",
                "country":"Nigeria"
             },
             {
                "firstName":"Steven",
                "lastName":"Adams",
                "temporaryDisplayName":"Adams, Steven",
                "personId":"203500",
                "teamId":"1610612740",
                "jersey":"12",
                "isActive":true,
                "pos":"C",
                "heightFeet":"6",
                "heightInches":"11",
                "heightMeters":"2.11",
                "weightPounds":"265",
                "weightKilograms":"120.2",
                "dateOfBirthUTC":"1993-07-20",
                "teams":[
                   {
                      "teamId":"1610612760",
                      "seasonStart":"2013",
                      "seasonEnd":"2019"
                   },
                   {
                      "teamId":"1610612740",
                      "seasonStart":"2020",
                      "seasonEnd":"2020"
                   }
                ],
                "draft":{
                   "teamId":"1610612760",
                   "pickNum":"12",
                   "roundNum":"1",
                   "seasonYear":"2013"
                },
                "nbaDebutYear":"2013",
                "yearsPro":"7",
                "collegeName":"Pittsburgh",
                "lastAffiliation":"Pittsburgh/New Zealand",
                "country":"New Zealand"
             }
          ]
       }
    }

    """.data(using: .utf8)!
    }
    
    // swiftlint:enable all
}
