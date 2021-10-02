import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
        return Todo.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Todo> {
        let todo = try req.content.decode(Todo.self)
        return todo.save(on: req.db).map { todo }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}


//QUERY

//.all() .first()

//filter(\.$name == "name")
// == | != | >= | > | < | <=
// ~~ | !~ | =~ | !=~ | ~= | !~=

//Field filter: comparing two columns

//group

//Aggregates
/*
count: Number of results
sum: Sum of results value
average: Average of result values
min: Minimum result value
max: Maximum result value
*/

//Chunk: separate the returning result, controlling memory usage
//filed: selected a subset of model's fields, fields not selected will be in an unitilized state.
//Unique: only distinct results (no duplicates).
//range: allow to chose a subset of the results
//join: allows to include one or more model's fields in the result.
//Alias: Allow you to join the same model to a query multiple times.
//update: supports updating more than one model at a time using update method.
//delete: supports deleting more than one model at a time using update method.
//paginate: Using the parameters (page, per) will return a desired set of results.
//sort: sorting results by field values 