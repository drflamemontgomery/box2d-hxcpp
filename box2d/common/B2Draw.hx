package box2d.common;

import box2d.dynamics.B2World;
import box2d.dynamics.B2Fixture;
import box2d.common.math.B2Vec2;
import box2d.common.math.B2Transform;
import box2d.Include;

class B2Draw {

  public static inline var SHAPE_BIT = 0x0001;
  public static inline var JOINT_BIT = 0x0002;
  public static inline var AABB_BIT = 0x0004;
  public static inline var PAIR_BIT = 0x0008;
  public static inline var CENTEROFMASS_BIT = 0x0010;

  public var flags : Int = 0x0000;

  public function new() {
  }
  
  public function drawPolygon(vertices:cpp.Pointer<B2Vec2>, vertexCount:Int, color:Int) {} 
  public function drawSolidPolygon(vertices:cpp.Pointer<B2Vec2>, vertexCount:Int, color:Int) {} 
  public function drawCircle(center:B2Vec2, radius:Float, color:Int) {} 
  public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:Int) {} 
  public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:Int) {}
  public function drawTransform(xf:B2Transform) {}
  public function drawPoint(p:B2Vec2, size:Float, color:Int) {}

  public function drawShape(fixture:cpp.ConstPointer<B2Fixture>, xf:B2Transform, color:Int) {
    untyped __cpp__("switch({0}->GetType()) {", fixture.raw);
    untyped __cpp__("
        case b2Shape::e_circle:
        {
        b2CircleShape* circle = (b2CircleShape*){0}->GetShape();

        b2Vec2 center = b2Mul({1}, circle->m_p);
        float radius = circle->m_radius;
        b2Vec2 axis = b2Mul({1}.q, b2Vec2(1.0f, 0.0f));", fixture.raw, xf);
        drawSolidCircle(untyped __cpp__("center"), untyped __cpp__("radius"),untyped __cpp__("axis"), color);
    untyped __cpp__("
        }
        break;");

    untyped __cpp__("
        case b2Shape::e_edge:
        {
        b2EdgeShape* edge = (b2EdgeShape*){0}->GetShape();
        b2Vec2 v1 = b2Mul({1}, edge->m_vertex1);
        b2Vec2 v2 = b2Mul({1}, edge->m_vertex2);", fixture.raw, xf);
        drawSegment(untyped __cpp__("v1"), untyped __cpp__("v2"), color);
        if(untyped __cpp__("edge->m_oneSided == false")) {
          drawPoint(untyped __cpp__("v1"), 4.0, color);
          drawPoint(untyped __cpp__("v2"), 4.0, color);
        }
    untyped __cpp__("
        }
        break;");

    untyped __cpp__("
        case b2Shape::e_chain:
        {
        b2ChainShape* chain = (b2ChainShape*){0}->GetShape();
        int32 count = chain->m_count;
        const b2Vec2 *vertices = chain->m_vertices;

        b2Vec2 v1 = b2Mul({1}, vertices[0]);
        for (int32 i = 1; i < count; ++i)
        {
          b2Vec2 v2 = b2Mul({1}, vertices[i]);", fixture.raw, xf);
          drawSegment(untyped __cpp__("v1"), untyped __cpp__("v2"), color);
    untyped __cpp__("
          v1 = v2;
        }
        }
        break;");

    untyped __cpp__("
        case b2Shape::e_polygon:
        {
        b2PolygonShape* poly = (b2PolygonShape*){0}->GetShape();
        int32 vertexCount = poly->m_count;
        b2Assert(vertexCount <= b2_maxPolygonVertices);
        b2Vec2 vertices[b2_maxPolygonVertices];
        for(int32 i = 0; i < vertexCount; ++i)
        {
          vertices[i] = b2Mul({1}, poly->m_vertices[i]);
        }", fixture.raw, xf);
        var hx_vertices : cpp.Pointer<B2Vec2> = untyped __cpp__("vertices");
        drawSolidPolygon(untyped __cpp__("vertices"), untyped __cpp__("vertexCount"), color);
    untyped __cpp__("
        }
        break;");
    
    untyped __cpp__("
        default:
        break;
        }
        ");
  }

  public function debugDraw(world:cpp.Pointer<B2World>) {
    if(flags & SHAPE_BIT != 0) {
      var body = world.value.getBodyList();
      while(untyped __cpp__("{0}", body.raw)) {
        var xf:B2Transform = body.value.getTransform();
        var f = body.value.getFixtureList();
        while(untyped __cpp__("{0}", f.raw)) {
          if(untyped __cpp__("{0}->GetType() == b2_dynamicBody && {0}->GetMass() == 0.0f", body.raw)) {
            drawShape(f, xf, 0xFF0000);
          }
          else if(body.value.isEnabled() == false) {
            drawShape(f, xf, 0x80804d);
          }
          else if(untyped __cpp__("{0}->GetType() == b2_staticBody", body.raw)) {
            drawShape(f, xf, 0x80e580);
          }
          else if(untyped __cpp__("{0}->GetType() == b2_kinematicBody", body.raw)) {
            drawShape(f, xf, 0x8080e5);
          }
          else if(body.value.isAwake()) {
            drawShape(f, xf, 0x999999);
          }
          else {
            drawShape(f, xf, 0xe5b2b2);
          }

          f = f.value.getNext();
        }
        body = body.value.getNext();
      }
    }
  }
}
