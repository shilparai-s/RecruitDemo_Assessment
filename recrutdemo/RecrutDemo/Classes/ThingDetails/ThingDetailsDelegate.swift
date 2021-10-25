import Foundation

protocol ThingDetailsDelegate {
    
    func thingDetails(viewController: ThingDetailsViewController, didLike thingModel: inout ThingCellViewModel)
    func thingDetails(viewController: ThingDetailsViewController, didDislike thingModel: inout ThingCellViewModel)
    func thingDetails(viewController: ThingDetailsViewController, willDismiss thingModel: inout ThingCellViewModel)
}
