import Fluent

struct CreateList : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(List.schema)
            .id()
            .field("title", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(List.schema).delete()
    }
}
