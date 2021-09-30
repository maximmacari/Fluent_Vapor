import Vapor
import Fluent

final class Governor: Model {
    static let schema = "governors"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @OptionalParent(key: "planet_id")
    var planet: Planet?
    
    init() {
    }

    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}