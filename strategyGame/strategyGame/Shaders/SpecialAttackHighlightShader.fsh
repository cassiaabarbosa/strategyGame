void main()
{
    vec4 val = texture2D(u_texture, v_tex_coord);
    
    float freq = (sin(u_time * 3.0)+ 1.0)/2.0;
    vec4 yellow = vec4(vec3(0.3+freq*0.2,0.3+freq*0.2,0.0),1.0);
    vec4 res = val + yellow;
    gl_FragColor = res;
}
