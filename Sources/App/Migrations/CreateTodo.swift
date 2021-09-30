import Fluent

struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema)
            .id()
            .field("title", .string, .required)
            .field("list_id", .uuid, .references(List.schema, "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema).delete()
    }
}
