import Vapor
import Fluent

final class Tag: Model {
    static let schema = "tags"

    //Unique identifier for this planet
    @ID(key: .id)
    var id: UUID?

    @Siblings(through: PlanetTag.self, from:  \.$tag, to: \.$planet)
    public var planets: [Planet]

    
    init() {
        
    }
    
}