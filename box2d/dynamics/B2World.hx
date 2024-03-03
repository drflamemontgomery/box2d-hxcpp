package box2d.dynamics;

import box2d.dynamics.B2Body;
import box2d.dynamics.B2Body.B2BodyDef;

import box2d.common.math.B2Vec2;
import box2d.common.B2Draw;
import box2d.Include;

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("box2d/box2d.h")
@:native("b2World")
extern class B2World {
  @:native("new b2World")  public static function create(gravity:B2Vec2):cpp.Pointer<B2World>;
  @:native("Step")         public function step(timeStep:Float, velIter:Int, posIter:Int):Void;
  @:native("ClearForces")  public function clearForces():Void;
  @:native("CreateBody")   public function createBody(def:cpp.ConstPointer<B2BodyDef>):cpp.ConstPointer<B2Body>;
  @:native("SetDebugDraw") public function setDebugDraw(debugDraw:cpp.Pointer<B2Draw>):Void;
  @:native("GetBodyList")  public function getBodyList() : cpp.ConstPointer<B2Body>;
}
