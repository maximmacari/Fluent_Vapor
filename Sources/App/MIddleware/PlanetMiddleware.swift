import Vapor
import Fluent

//Example middle ware that capitalized names.
struct PlanetMiddleware: ModelMiddleware {
    func create(model: Planet, on db: Database, next: AnyModelResponder) -> EventLoopFuture<Void> {
        //the model can be altered here before ot is created
        model.name = model.name.capitalized
        return next.create(model, on: db).map {
            //Once the planet has been created, the code ehere will be executed
            print("Planet \(model.name) was created")
        }
    }
}