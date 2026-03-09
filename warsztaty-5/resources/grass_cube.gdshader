shader_type spatial;
render_mode unshaded;

uniform sampler2D top_texture : source_color, filter_nearest;
uniform sampler2D side_texture : source_color, filter_nearest;
uniform sampler2D bottom_texture : source_color, filter_nearest;

void fragment() {
    vec3 normal = normalize(NORMAL);
    
    vec3 albedo;
    if (abs(NORMAL.y) > 0.5) {
        if (NORMAL.y > 0.0) {
            albedo = texture(top_texture, UV * vec2(3.0, 2.0)).rgb;
        } else {
            albedo = texture(bottom_texture, UV * vec2(3.0, 2.0)).rgb;
        }
    } else {
        albedo = texture(side_texture, UV * vec2(3.0, 2.0)).rgb;
    }
    
    ALBEDO = albedo;
}