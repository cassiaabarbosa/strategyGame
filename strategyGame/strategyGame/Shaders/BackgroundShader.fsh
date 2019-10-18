//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc

void main() {

    vec3 col = 0.5 + 0.5*cos(u_time+v_tex_coord.xyx+vec3(0,2,4));
    gl_FragColor = vec4(col, 1.0);
}
