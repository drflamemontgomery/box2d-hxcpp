package box2d.dynamics;

import box2d.common.math.B2Vec2;
import box2d.common.math.B2Transform;
import box2d.dynamics.B2Fixture;
import box2d.dynamics.B2Fixture.B2FixtureDef;
import box2d.Include;

@:include("box2d/b2_body.h")
extern enum abstract B2BodyType(Int) {
  @:native("b2_staticBody")    var STATIC_BODY;
  @:native("b2_kinematicBody") var KINEMATIC_BODY;
  @:native("b2_dynamicBody")   var DYNAMIC_BODY;
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/b2_body.h")
@:native("b2BodyDef")
extern class B2BodyDef {
  @:native("new b2BodyDef") public static function create():cpp.Pointer<B2BodyDef>;
  public var type:B2BodyType;
  public var position:B2Vec2;
  public var angle:Float;
  public var linearVelocity:B2Vec2;
  public var angularVelocity:Float;
  public var linearDamping:Float;
  public var angularDamping:Float;
  public var allowSleep:Bool;
  public var awake:Bool;
  public var fixedRotation:Bool;
  public var bullet:Bool;
  public var enabled:Bool;
  public var userData:B2Settings.B2BodyUserData;
  public var gravityScale:Float;
}

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/b2_body.h")
@:native("b2Body")
extern class B2Body {
  @:native("GetPosition") public function getPosition() : B2Vec2;
  @:native("GetMass") public function getMass() : Float;
  @:native("CreateFixture") public function createFixture(def:cpp.ConstPointer<B2FixtureDef>) : cpp.ConstPointer<B2Fixture>;
  @:native("GetNext") public function getNext() : cpp.ConstPointer<B2Body>;
  @:native("GetFixtureList") public function getFixtureList() : cpp.ConstPointer<B2Fixture>;
  @:native("GetTransform") public function getTransform() : B2Transform;
  @:native("IsEnabled") public function isEnabled() : Bool;
  @:native("IsAwake") public function isAwake() : Bool;
}
