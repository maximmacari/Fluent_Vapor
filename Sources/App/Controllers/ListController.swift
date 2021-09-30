import Fluent
import Vapor

struct ListController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let lists = routes.grouped("lists")
        lists.get(use: index)
        lists.post(use: create)
        lists.group(":listID") { list in
            list.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[List]> {
        return List.query(on: req.db).with(\.$todos).all()
    }

    func create(req: Request) throws -> EventLoopFuture<List> {
        let list = try req.content.decode(List.self)
        return list.save(on: req.db).map { list }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return List.find(req.parameters.get("listID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
