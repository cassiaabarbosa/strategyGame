void main()
{
    // pixel value at the coordenate
    vec4 val = texture2D(u_texture, v_tex_coord);
    if (val.a == 0.0) {
        gl_FragColor = vec4(0.0);
    } else {
        float freq = abs(sin(u_time * 2.0));
        vec3 white = vec3(0.2+freq*0.15);
        vec4 res = vec4(vec3(val.rgb + white), val.a);
        gl_FragColor = res;
    }
}
