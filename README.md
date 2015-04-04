# glsl-earth

[![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)

![earth](http://i.imgur.com/uz2WYlL.png)

Quickly get a spinning Earth-like planet on a black background in GLSL. This is not distance field rendering, just a 2D effect.

```glsl
precision mediump float;

uniform float iGlobalTime;
uniform vec3  iResolution;

#pragma glslify: planet = require('glsl-earth')

void main() {
  vec2 uv = gl_FragCoord.xy / iResolution.xy;

  //the rotation
  vec2 rot = vec2(iGlobalTime*0.03, iGlobalTime*0.01);
  
  //% of screen
  float size = 0.75;

  //create our planet
  vec3 color = planet(uv, iResolution.xy, size, rot);
  
  gl_FragColor.rgb = color;
  gl_FragColor.a = 1.0;
}
```

PRs welcome for improvements/optimizations.

## Usage

[![NPM](https://nodei.co/npm/glsl-earth.png)](https://www.npmjs.com/package/glsl-earth)

#### `vec3 color = planet(vec2 uv, vec2 resolution, float size, vec2 rotation)`

Gets a planet based on the screen `uv` and `resolution`. The `size` is how big the planet shoul be, where 1.0 fits the screen. `rotation` is how much to rotate the planet.

#### `vec3 color = planet(vec2 uv, vec2 resolution, float size)`

The same as above but with no rotation.

#### `vec3 color = planet(vec2 uv, vec2 resolution)`

The same as above but with no rotation and a default size of 1.0

## License

MIT, see [LICENSE.md](http://github.com/mattdesl/glsl-earth/blob/master/LICENSE.md) for details.
