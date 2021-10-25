import Foundation


struct ThingsTableViewModel {
    
    let imageProvider = ImageProvider()
    //private var things = mockData()
    var datasourceCount: Int {
        return thingsViewModel.count
    }
    
    var thingsViewModel : [ThingCellViewModel] =  {
        let things = mockData()
        let viewModel = things.compactMap( {
            ThingCellViewModel(name: $0.name, isLiked: Observable($0.like), image: $0.image)
        })
        return viewModel
    }()
    
    mutating func thing(for indexPath: IndexPath) -> ThingCellViewModel {
        return self.thingsViewModel[indexPath.row]
    }
    
    mutating func bindModelWithView(cell: ThingCell, at indexPath: IndexPath) {
       // things[indexPath.row].modelCell = cell
    }
    
}











