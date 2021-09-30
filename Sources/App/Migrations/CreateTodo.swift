import Fluent

struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos")
            .id()
            .field("title", .string, .required)
            .field("id", .uuid, .references("lists", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos").delete()
    }
}
