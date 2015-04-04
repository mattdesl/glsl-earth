#pragma glslify: snoise = require('glsl-noise/simplex/2d')

float clouds( vec2 coord ) {
  //standard fractal
  float n = snoise(coord);
  n += 0.5 * snoise(coord * 2.0);
  n += 0.25 * snoise(coord * 4.0);
  n += 0.125 * snoise(coord * 8.0);
  n += 0.0625 * snoise(coord * 16.0);
  n += 0.03125 * snoise(coord * 32.0);
  n += 0.03125 * snoise(coord * 32.0);
  return n;
}

vec3 planet(vec2 uv, vec2 resolution, float size, vec2 rotation) {
  float __PI__ = 3.14;
  float aspect = resolution.x / resolution.y;
  vec2 norm = 2.0 * uv - 1.0;
  norm.x *= aspect;

  float r = length(norm) / size;
  float phi = atan(norm.y, norm.x);
  
  //spherize
  r = 2.0 * asin(r) / __PI__;
  
  vec2 coord = vec2(r * cos(phi), r * sin(phi));
  coord = coord/2.0 + 0.5;

  coord += rotation;
  float n = clouds(coord*3.0);
  
  vec2 position = uv - 0.5;
  position.x *= aspect;
  float len = length(position);
    
  float terrain = smoothstep(0.1, 0.0, n); //block out some terrain
  
  //green
  vec3 terrainColor = vec3(76.0/255.0, 147.0/255.0, 65.0/255.); 
  terrainColor = mix(vec3(131.0/255.0, 111.0/255.0, 39.0/255.), terrainColor, smoothstep(0.2, .7, 1.0-n));
  
  //mix in brown edge
  terrainColor = mix(vec3(94.0/255.0, 67.0/255.0, 31.0/255.), terrainColor, smoothstep(0.0, 0.18, n));
  terrainColor += n*0.3;
  
  //water
  vec3 color = vec3(81.0/255.0, 121.0/255.0, 181.0/255.); 
  color -= (1.0-n*4.0)*0.03;
  
  //mix terrain with water
  color = mix(terrainColor, color, terrain); 
  
  //anti-alias
  color *= smoothstep(0.5*size, 0.495*size, len);
  //shadow
  color *= smoothstep(0.625*size, 0.25*size, len);
  color = clamp(color, 0.0, 1.0);
  return color;
}

vec3 planet(vec2 uv, vec2 resolution, float size) {
  return planet(uv, resolution, size, vec2(0.0));
}

vec3 planet(vec2 uv, vec2 resolution) {
  return planet(uv, resolution, 1.0, vec2(0.0));
}

#pragma glslify: export(planet)