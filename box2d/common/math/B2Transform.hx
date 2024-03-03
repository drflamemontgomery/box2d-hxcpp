package box2d.common.math;

import box2d.common.math.B2Vec2;
import box2d.common.math.B2Rot;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Transform")
extern class B2Transform {
  public var p:B2Vec2;
  public var q:B2Rot;
}
