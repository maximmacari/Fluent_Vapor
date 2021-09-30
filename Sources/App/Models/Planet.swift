import Vapor
import Fluent

final class Planet: Model, Content {
    //Name of the table or collection
    static let schema = "planets"

    //Unique identifier for this planet
    @ID(key: .id)
    var id: UUID?

    //Planet's name
    @Field(key: "name")
    var name: String

    @OptionalParent(key: "star_id")//@Parent(key: "star_id")
    var star: Star?

    //Example of a optional child relation(1-1)
    //@OptionalChild(for: \.$planet)
    //var governor: Governor?

    @Siblings(through: PlanetTag.self, from: \.$planet, to: \.$tag)
    public var tags: [Tag]

    init() {
    }
    
    init(id: UUID? = nil, name: String, starID: UUID? = nil) {
        self.id = id
        self.name = name
        self.$star.id = starID
    }
}

//Relations
/*
    Parent / Child (1-1)
    Parent / Children (1-n)
    siblings (n-n)
*/