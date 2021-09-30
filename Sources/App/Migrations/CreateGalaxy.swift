import Fluent

struct CreateGalaxy: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Galaxy.schema)
            .id()
            .field("name", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Galaxy.schema).delete()
    }
}
