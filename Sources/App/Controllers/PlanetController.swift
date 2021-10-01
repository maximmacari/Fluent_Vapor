import Fluent
import Vapor

struct PlanetController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let planets = routes.grouped("planets")
        planets.get(use: index)
        planets.get("count") { req in
            try count(req: req)
        }
        planets.post(use: create)
        planets.group(":planetID") { planet in
            planet.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Planet]> {
        return Planet.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Planet> {
        let planet = try req.content.decode(Planet.self)
        return planet.save(on: req.db).map { planet }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Planet.find(req.parameters.get("planetID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func count(req: Request) throws -> EventLoopFuture<Int> {
        Planet.query(on: req.db).count()
    }
}
