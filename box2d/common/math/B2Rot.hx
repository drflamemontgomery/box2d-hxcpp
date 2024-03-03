package box2d.common.math;

import box2d.common.math.B2Vec2;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Rot")
extern class B2Rot {
  public var s:Float;
  public var c:Float;
}
