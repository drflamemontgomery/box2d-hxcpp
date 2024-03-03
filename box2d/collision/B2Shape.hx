package box2d.collision;

import box2d.Include;

@:include("box2d/box2d.h")
@:native("b2Shape::Type")
extern enum B2ShapeType {
  @:native("e_circle")    CIRCLE;
  @:native("e_edge")      EDGE;
  @:native("e_polygon")   POLYGON;
  @:native("e_chain")     CHAIN;
  @:native("e_typeCount") TYPECOUNT;
}


@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Shape")
extern class B2Shape {
  public var m_radius : Float;
}
