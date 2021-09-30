import Fluent

struct CreatePlanetTag: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(PlanetTag.schema)
            .id()
            .unique(on: "planet_id", "tag_id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(PlanetTag.schema).delete()
    }
}
