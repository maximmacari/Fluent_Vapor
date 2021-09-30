import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Parent(key: "list_id")
    var list: List

    init() { }

    init(id: UUID? = nil, title: String, listId: UUID) {
        self.id = id
        self.title = title
        self.$list.id = listId
    }
}
