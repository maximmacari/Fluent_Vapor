import Vapor
import Fluent

final class Star: Model,Content {
    static let schema = "stars"

    @ID(key: .id)
    var id: UUID?

    //Star's name
    @Field(key: "name")
    var name: String

    @Parent(key: "galaxy_id")
    var galaxy: Galaxy

    //Children relation (1-n)
    @Children(for: \.$star)
    var planets: [Planet]

    
    init() {
    }

    
    init(id: UUID? = nil, name: String, galaxyID: UUID) {
        self.id = id
        self.name = name
        self.$galaxy.id = galaxyID
    }
    
    
}