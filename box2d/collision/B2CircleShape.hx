package box2d.collision;

import box2d.Include;
import box2d.common.math.B2Vec2;
import box2d.common.math.B2Vec2.B2Vec2Ptr;
import box2d.collision.B2Shape;
import box2d.collision.B2Shape.B2ShapePtr;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2CircleShape")
extern class B2CircleShapePtr extends B2ShapePtr {
  @:native("new b2CircleShape") public static function create() : cpp.Pointer<B2CircleShapePtr>;
  public var m_p : B2Vec2Ptr;
}

class B2CircleShape extends B2Shape {
  public var ptr(default, null) : cpp.Pointer<B2CircleShapePtr>;
  public var m_p : B2Vec2;

  override function getPtr():cpp.Pointer<B2ShapePtr> {
    return untyped __cpp__("(b2Shape*)({0})", ptr);
  }

  public function new() {
    ptr = B2CircleShapePtr.create();
    m_p = B2Vec2.fromPtr(untyped __cpp__("&{0}", ptr.value.m_p));
  }
}
