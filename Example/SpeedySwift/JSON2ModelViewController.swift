//
//  ViewController.swift
//  SSJSON2Model
//
//  Created by Quinn on 2021/10/17.
//

import UIKit
import SpeedySwift

let jsonstr = """
{
"id": 1001,
"name": "Durian",
"points": 600,
"parameters": {
    "size": "80*80",
    "area": "Thailand",
    "quality": "bad"
},
"description": "A fruit with a distinctive scent."
}
"""

struct GroceryProduct: SSCoadble {
    var id: Int
    var name: String
    var points: Int?
    var description: String?
    var parameters: Parameters?
    
    struct Parameters: SSCoadble {
        var size: String?
        var area: String?
        var quality: Quality?
        /// 如果json中没有该属性，但是自己想用，可以添加lazy并初始化
        lazy var myhh:String = ""
    }
    
    enum Quality: String, SSCoadble {
        case good, caporal, bad
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SS.shared.openLog = true
        
        let model = jsonstr.toModel(GroceryProduct.self)
        
        let data = model?.toData()
        
        let dict = model?.toDict()
        
        let dict2 = data?.toDict()
        
        let model2 = data?.toModel(GroceryProduct.self)
        
        SS.debug(model)
        SS.debug(model2)
        SS.debug(dict ?? [:])
        SS.debug(dict2 ?? [:])
        SS.debug(data)
    }

    /*
     SS🐻 2021.10.17 13:35:34 控制台 ViewController.swift[59] + viewDidLoad():
       [Optional(SSJSON2Model.GroceryProduct(id: 1001, name: "Durian", points: Optional(600), description: Optional("A fruit with a distinctive scent."), parameters: Optional(SSJSON2Model.GroceryProduct.Parameters(size: Optional("80*80"), area: Optional("Thailand"), quality: Optional(SSJSON2Model.GroceryProduct.Quality.bad)))))]
     SS🐻 2021.10.17 13:35:34 控制台 ViewController.swift[60] + viewDidLoad():
       [Optional(SSJSON2Model.GroceryProduct(id: 1001, name: "Durian", points: Optional(600), description: Optional("A fruit with a distinctive scent."), parameters: Optional(SSJSON2Model.GroceryProduct.Parameters(size: Optional("80*80"), area: Optional("Thailand"), quality: Optional(SSJSON2Model.GroceryProduct.Quality.bad)))))]
     SS🐻 2021.10.17 13:35:34 控制台 ViewController.swift[61] + viewDidLoad():
       [["name": Durian, "parameters": {
         area = Thailand;
         quality = bad;
         size = "80*80";
     }, "id": 1001, "description": A fruit with a distinctive scent., "points": 600]]
     SS🐻 2021.10.17 13:35:34 控制台 ViewController.swift[62] + viewDidLoad():
       [["description": A fruit with a distinctive scent., "points": 600, "name": Durian, "id": 1001, "parameters": {
         area = Thailand;
         quality = bad;
         size = "80*80";
     }]]
     SS🐻 2021.10.17 13:35:34 控制台 ViewController.swift[63] + viewDidLoad():
       [Optional(154 bytes)]

     */

}

