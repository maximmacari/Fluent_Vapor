import Fluent

struct CreateStar: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Star.schema)
            .id()
            .field("name", .string, .required)
            .field("galaxy_id", .uuid, .references(Galaxy.schema, "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Star.schema).delete()
    }
}
