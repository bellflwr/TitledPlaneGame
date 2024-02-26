// NOTE: Shader automatically converted from Godot Engine 4.1.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec4 grass : source_color;
uniform vec4 rock : source_color;
uniform vec4 snow : source_color;


uniform float point_size : hint_range(0,128);
uniform float roughness : hint_range(0,1);
uniform float specular;
uniform float metallic;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform sampler2D noise;

varying float flatness;

varying vec3 world_position;

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
	flatness = dot(NORMAL, vec3(0, 1, 0));
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	float height = texture(noise, world_position.xz / 1000.0).x * 250.0;
	height += world_position.y;
	
	if(height > 600.0){
		ALBEDO = snow.rgb;
	} else if (height > 200.0){
		ALBEDO = rock.rgb;
	} else {
		ALBEDO = grass.rgb;
	}
	
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}
