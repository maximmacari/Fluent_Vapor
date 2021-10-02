import Fluent

struct CreatePlanet: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Planet.schema)
            .id()
            .field("name", .string, .required)
            .field("star_id", .uuid, .references(Star.schema, "id")) //.required
            //.ignoreExisting()
            .create() //.update() | .delete()
    }

    //DATA TYPES 
    /*
    .primitives
    .dictionary
    .array
    .enum
    */

    //Field constraints
    // .required: disallow nil values
    // .references: requires that this field's value matches a valuue of the referenced schema
    // .indentifier: Denotes the primary key

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Planet.schema).delete()
    }
}
