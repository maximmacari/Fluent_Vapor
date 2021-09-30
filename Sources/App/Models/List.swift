import Fluent
import Vapor

final class List: Model, Content {
    static let schema = "lists"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Children(for: \.$list)
    var todos: [Todo]

    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
