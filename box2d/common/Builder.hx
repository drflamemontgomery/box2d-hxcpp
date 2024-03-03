package box2d.common;

import box2d.dynamics.B2World;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2Body.B2BodyType;
import box2d.dynamics.B2Fixture;
import box2d.dynamics.B2Fixture.B2Filter;
import box2d.collision.B2Shape;

typedef BodySettings = {
  var ?isStatic : Bool;
  var ?isKinematic : Bool;
  var ?isDynamic : Bool;
  var ?position : { x : Float, y : Float };
  var ?angle : Float;
  var ?linearVelocity : { x : Float, y : Float };
  var ?angularVelocity : Float;
  var ?linearDamping : Float;
  var ?angularDamping : Float;
  var ?allowSleep : Bool;
  var ?awake : Bool;
  var ?fixedRotation : Bool;
  var ?bullet : Bool;
  var ?enabled : Bool;
  var ?userData : Dynamic;
  var ?gravityScale : Float;
  var ?fixtures : Array<FixtureSettings>;
};

typedef FixtureSettings = {
  > ShapeSettings,
  var ?userData : Dynamic;
  var ?friction : Float;
  var ?restitution : Float;
  var ?restitutionThreshold : Float;
  var ?density : Float;
  var ?isSensor : Bool;
  var ?filter : {?categoryBits:cpp.UInt16, ?maskBits:cpp.UInt16, ?groupIndex:cpp.UInt16};
};

typedef ShapeSettings = {
  var ?circle : {
    var ?position : {x : Float, y : Float};
    var radius : Float;
  };
  var ?edge : {
    var vertex1 : { x : Float, y : Float };
    var vertex2 : { x : Float, y : Float };
    var ?vertex0 : { x : Float, y : Float };
    var ?vertex3 : { x : Float, y : Float };
  };
  var ?box : {
    var halfWidth : Float;
    var halfHeight : Float;
    var ?center : {x : Float, y : Float};
    var ?angle : Float;
  };
  var ?polygon : {
    var vertices : Array<{x : Float, y : Float}>;
  };
  var ?chain : {
    var vertices : Array<{x : Float, y : Float}>;
    var ?prevVertex : {x : Float, y : Float};
    var ?nextVertex : {x : Float, y : Float};
  };
};

class Builder {

  public static function buildBody(world:cpp.Pointer<B2World>, settings:BodySettings) : cpp.ConstPointer<B2Body> {
    untyped __cpp__("b2BodyDef bd");   
    if(settings.isStatic != null && settings.isStatic) untyped __cpp__("bd.type = b2_staticBody"); 
    else if(settings.isDynamic != null && settings.isDynamic) untyped __cpp__("bd.type = b2_dynamicBody"); 
    else if(settings.isKinematic != null && settings.isKinematic) untyped __cpp__("bd.type = b2_kinematicBody"); 
 
    if(settings.position != null) untyped __cpp__("bd.position.Set({0}, {1})", settings.position.x, settings.position.y); 
    if(settings.angle != null) untyped __cpp__("bd.angle = {0}", settings.angle); 
    if(settings.linearVelocity != null) untyped __cpp__("bd.linearVelocity.Set({0}, {1})", settings.linearVelocity.x, settings.linearVelocity.y); 
    if(settings.angularVelocity != null) untyped __cpp__("bd.angularVelocity = {0}", settings.angularVelocity); 
    if(settings.linearDamping != null) untyped __cpp__("bd.linearDamping = {0}", settings.linearDamping); 
    if(settings.angularDamping != null) untyped __cpp__("bd.angularDamping = {0}", settings.angularDamping); 
    if(settings.allowSleep != null) untyped __cpp__("bd.allowSleep = {0}", settings.allowSleep); 
    if(settings.awake != null) untyped __cpp__("bd.awake = {0}", settings.awake); 
    if(settings.fixedRotation != null) untyped __cpp__("bd.fixedRotation = {0}", settings.fixedRotation); 
    if(settings.bullet != null) untyped __cpp__("bd.bullet = {0}", settings.bullet); 
    if(settings.enabled != null) untyped __cpp__("bd.enabled = {0}", settings.enabled); 
    if(settings.userData != null) untyped __cpp__("bd.userData.pointer = (uintptr_t){0}", settings.userData); 
    if(settings.gravityScale != null) untyped __cpp__("bd.gravityScale = {0}", settings.gravityScale); 
    var body = world.value.createBody(untyped __cpp__("&bd"));

    if(settings.fixtures != null) {
      for(setting in settings.fixtures) {
        buildFixture(body, setting);
      }
    }
    return body;
  }

  static inline function createChain(settings:ShapeSettings) : cpp.ConstPointer<B2Shape> {
    untyped __cpp__("b2ChainShape c");
    return untyped __cpp__("&c");
  }

  public static function buildFixture(body:cpp.ConstPointer<B2Body>, settings:FixtureSettings) : cpp.ConstPointer<B2Fixture> {
    untyped __cpp__("b2FixtureDef fd");
    untyped __cpp__("b2CircleShape c");
    untyped __cpp__("b2EdgeShape e");
    untyped __cpp__("b2PolygonShape p");
    untyped __cpp__("b2ChainShape ch");
    if(settings.circle != null) {
      if(settings.circle.position != null) untyped __cpp__("c.m_p.Set({0}, {1})", settings.circle.position.x, settings.circle.position.y);
      untyped __cpp__("c.m_radius = {0}", settings.circle.radius);
      untyped __cpp__("fd.shape = &c");
    }
    else if(settings.edge != null) {
      if(settings.edge.vertex0 != null && settings.edge.vertex3 != null) {
        untyped __cpp__("e.SetOneSided(
              b2Vec2({0}, {1}),
              b2Vec2({2}, {3}),
              b2Vec2({4}, {5}),
              b2Vec2({6}, {7})
              )",
            settings.edge.vertex0.x, settings.edge.vertex0.y,
            settings.edge.vertex1.x, settings.edge.vertex1.y,
            settings.edge.vertex2.x, settings.edge.vertex2.y,
            settings.edge.vertex3.x, settings.edge.vertex3.y);
      }
      else {
        untyped __cpp__("e.SetTwoSided(b2Vec2({0}, {1}), b2Vec2({2}, {3}))",
            settings.edge.vertex1.x, settings.edge.vertex1.y,
            settings.edge.vertex2.x, settings.edge.vertex2.y);
      }
      untyped __cpp__("fd.shape = &e");
    }
    else if(settings.box != null) {
      if(settings.box.center != null && settings.box.angle != null) {
        untyped __cpp__("p.SetAsBox({0}, {1}, b2Vec2({2}, {3}), {4})",
            settings.box.halfWidth, settings.box.halfHeight,
            settings.box.center.x, settings.box.center.y,
            settings.box.angle);
      } else {
        untyped __cpp__("p.SetAsBox({0}, {1})", settings.box.halfWidth, settings.box.halfHeight);
      }
      untyped __cpp__("fd.shape = &p");
    }
    else if(settings.polygon != null) {
      untyped __cpp__("b2Vec2 *vertices = (b2Vec2*)malloc(sizeof(b2Vec2)*{0})", settings.polygon.vertices.length);
      for(i in 0...settings.polygon.vertices.length) {
        untyped __cpp__("vertices[{0}].Set({1}, {2})", i, settings.polygon.vertices[i].x, settings.polygon.vertices[i].y);
      }
      untyped __cpp__("p.Set((const b2Vec2*)vertices, {0})", settings.polygon.vertices.length);
      untyped __cpp__("fd.shape = &p");
      untyped __cpp__("free(vertices)");
    }
    else if(settings.chain != null) {
      untyped __cpp__("b2Vec2 *vertices = (b2Vec2*)malloc(sizeof(b2Vec2)*{0})", settings.chain.vertices.length);
      for(i in 0...settings.chain.vertices.length) {
        untyped __cpp__("vertices[{0}].Set({1}, {2})", i, settings.chain.vertices[i].x, settings.chain.vertices[i].y);
      }

      if(settings.chain.prevVertex != null && settings.chain.nextVertex != null) {
        untyped __cpp__("ch.CreateChain((const b2Vec2*)vertices, {0}, b2Vec2({1}, {2}), b2Vec2({3}, {4}))",
            settings.chain.vertices.length,
            settings.chain.prevVertex.x, settings.chain.prevVertex.y,
            settings.chain.nextVertex.x, settings.chain.nextVertex.y);
      }
      else {
        untyped __cpp__("ch.CreateLoop((const b2Vec2*)vertices, {0})", settings.chain.vertices.length); 
      }

      untyped __cpp__("fd.shape = &ch");
      untyped __cpp__("free(vertices)");
    }
    else {
      throw "Error: Fixture Needs A Shape";
    }

    if(settings.userData != null) untyped __cpp__("fd.userData.pointer = (uintptr_t){0}", settings.userData);
    if(settings.friction != null) untyped __cpp__("fd.friction = {0}", settings.friction);
    if(settings.restitution != null) untyped __cpp__("fd.restitution = {0}", settings.restitution);
    if(settings.restitutionThreshold != null) untyped __cpp__("fd.restitutionThreshold = {0}", settings.restitutionThreshold);
    if(settings.density != null) untyped __cpp__("fd.density = {0}", settings.density);
    if(settings.isSensor != null) untyped __cpp__("fd.isSensor = {0}", settings.isSensor);
    if(settings.filter != null) {
      if(settings.filter.categoryBits != null) untyped __cpp__("fd.filter.categoryBits = {0}", settings.filter.categoryBits);
      if(settings.filter.maskBits != null) untyped __cpp__("fd.filter.maskBits = {0}", settings.filter.maskBits);
      if(settings.filter.groupIndex != null) untyped __cpp__("fd.filter.groupIndex = {0}", settings.filter.groupIndex);
    }
    var fixture = body.value.createFixture(untyped __cpp__("&fd"));
    return fixture;
  }
}
