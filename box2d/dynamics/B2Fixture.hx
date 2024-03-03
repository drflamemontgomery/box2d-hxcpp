package box2d.dynamics;

import box2d.common.math.B2Vec2;
import box2d.B2Settings.B2FixtureUserData;
import box2d.collision.B2Shape;
import box2d.collision.B2Shape.B2ShapeType;
import box2d.Include;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Filter")
extern class B2Filter {
  @:native("new b2Filter") public static function create():cpp.Pointer<B2Filter>;
  public var categoryBits : cpp.UInt16;
  public var maskBits : cpp.UInt16;
  public var groupIndex : cpp.Int16;
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2FixtureDef")
extern class B2FixtureDef {
  @:native("new B2FixtureDef") public static function create() : cpp.Pointer<B2FixtureDef>;
  public var shape : cpp.ConstPointer<B2Shape>;
  public var userData : B2FixtureUserData;
  public var friction : Float;
  public var restitution : Float;
  public var restitutionThreshold : Float;
  public var density : Float;
  public var isSensor : Bool;
  public var filter : B2Filter;
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Fixture")
extern class B2Fixture {
  @:native("GetType") public function getType() : B2ShapeType;
  @:native("GetNext") public function getNext() : cpp.ConstPointer<B2Fixture>;
}
