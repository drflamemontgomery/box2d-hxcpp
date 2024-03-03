package box2d;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2BodyUserData")
extern class B2BodyUserData {
  @:native("new b2BodyUserData") public static function create():cpp.Pointer<B2BodyUserData>;
  public var pointer:cpp.Pointer<cpp.UInt32>;
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2FixtureUserData")
extern class B2FixtureUserData {
  @:native("new b2FixtureUserData") public static function create():cpp.Pointer<B2FixtureUserData>;
  public var pointer:cpp.Pointer<cpp.UInt32>;
}
