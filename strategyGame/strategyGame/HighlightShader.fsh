void main()
{
    float freq = (sin(u_time * 3.0)+ 1.0)/2.0;
    vec4 white = vec4(vec3(0.3+freq*0.2),1.0);
    vec4 res = v_color_mix + white;
    gl_FragColor = res;
}
