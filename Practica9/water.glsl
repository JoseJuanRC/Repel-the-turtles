#define PI 3.1415926535
#ifdef GL_ES
  precision mediump float;
#endif

  uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float distanceValue;
uniform float maxDistance;

uniform vec3 rippleColor;
uniform vec3 waterColor;

vec2 random_noise (vec2 point, float offset)
{
  mat2 m = mat2(15.27, 47.63, 99.41, 89.98);
  vec2 tmp = point.x * m[0] + point.y * m[1];
  point = fract(sin(vec2(tmp)) * 46839.32);
  return vec2(sin(point.y*+offset)*0.5+0.5, cos(point.x*offset)*0.5+0.5);
}

float voronoi(vec2 point, float AngleOffset, float CellDensity)
{
  float res = 0.;
  vec2 g = floor(point * CellDensity);
  vec2 f = fract(point * CellDensity);

  for (int y=-1; y<=1; y++)
    for (int x=-1; x<=1; x++)
    {
      vec2 currentPoint = vec2(x, y);
      vec2 offset = random_noise(currentPoint + g, AngleOffset);
      float d = distance(currentPoint + offset, f);
      res += 1. / pow(dot(d, d), 8.);
    }

  return pow(1. / res, 0.5);
  ;
}

void main() {
  vec2 st = 100.*gl_FragCoord.xy/u_resolution.xy;

  vec3 color = vec3(voronoi(st, u_time, 0.04));


  color*= rippleColor;
  color = waterColor + color;

  // Controlamos la distorsión con respecto un punto
  vec3 distortion = color; 
  if (length(st-100.*u_mouse/u_resolution.xy)<distanceValue) {
    distortion = waterColor;
    if (mod(length(st-100.*u_mouse/u_resolution.xy), distanceValue/4.)<0.5)
      distortion = rippleColor;
  } else if (length(st-100.*u_mouse/u_resolution.xy)< distanceValue*1.02) 
    distortion = rippleColor;

  // Cuando el circulo sea pequeño tendra el color de distorsión y a medida que crezca se irá volviendo el valor de la variable color
  color = mix(distortion, color, sin(PI/2*distanceValue/maxDistance));

  gl_FragColor = vec4(color.r, color.g, color.b, 0.65);
}
