shader_type canvas_item;

uniform sampler2D noise;

vec2 random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}


void fragment() {
	
	//UV.x + TIME * nSpeed, UV.y + TIME * nSpeed
	
	vec2 newUV = vec2(UV.x * TIME , UV.y * TIME);
	newUV = random(newUV);
	COLOR = texture(noise, newUV);
	
	
	
}



