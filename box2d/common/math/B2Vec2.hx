package box2d.common.math;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2Vec2")
extern class B2Vec2 {
  @:native("new b2Vec2")    public static function create(xIn:Float, yIn:Float):cpp.Pointer<B2Vec2>;
  @:native("SetZero")       public function setZero():Void;
  @:native("Set")           public function set(x_:Float, y_:Float):Void;
  @:native("Length")        public function length():Float;
  @:native("LengthSquared") public function lengthSquared():Float;

  public var x : Float;
  public var y : Float;
}

@:include("box2d/box2d.h")
@:native("const b2Vec2*")
extern class ConstB2Vec2Array {
  public var x : Float;
  public var y : Float;
}
