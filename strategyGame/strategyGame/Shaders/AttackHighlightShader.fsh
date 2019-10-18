void main()
{
    float freq = (sin(u_time * 3.0)+ 1.0)/2.0;
    vec4 red = vec4(vec3(0.7+freq*0.2,0.0,0.0),1.0);
    vec4 res = v_color_mix + red;
    gl_FragColor = res;
}
