shader_type canvas_item;

uniform float value : hint_range(0,1);
uniform sampler2D noise_texture;

void fragment(){
	vec4 currentPixel = texture(TEXTURE, SCREEN_UV);
	vec4 noisePixel = texture(noise_texture,UV);
	
	if(noisePixel.r > value)
	{
		COLOR.a -= 1f		
	}
	else
	{
		COLOR = currentPixel;
	}
}