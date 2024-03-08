package box2d.collision;

@:include("box2d/box2d.h")
@:native("b2Shape::Type")
extern enum B2ShapeType {
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Shape")
extern class B2Shape {
}
