import Fluent

struct CreatePlanet: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Planet.schema)
            .id()
            .field("name", .string, .required)
            .field("star_id", .uuid, .references(Star.schema, "id")) //.required
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Planet.schema).delete()
    }
}
