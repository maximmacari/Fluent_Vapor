import Fluent

struct CreateGovernor: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Governor.schema)
            .id()
            .field("name", .string, .required)
            .field("planet_id", .uuid, .required, .references(Planet.schema, "id"))
            .unique(on: "planet_id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Governor.schema).delete()
    }
}
