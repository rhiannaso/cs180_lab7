#version 330 core
uniform sampler2D Texture0;

in vec2 vTexCoord;
//interpolated normal and light vector in camera space
in vec3 fragNor;
in vec3 lightDir;
//position of the vertex in camera space
in vec3 EPos;

out vec4 Outcolor;

vec3 MatAmb;
vec3 MatDif;
vec3 MatSpec;

float dC;
float NH;
float NHPow;

void main() {
  vec4 texColor0 = texture(Texture0, vTexCoord);

  	//to set the out color as the texture color 
  	//Outcolor = texColor0;

    vec3 normal = normalize(fragNor);
	vec3 light = normalize(lightDir);

    dC = max(0, (normal.x*light.x) + (normal.y*light.y) + (normal.z*light.z));

    vec3 V = -1*EPos;
    vec3 H = normalize(light + normalize(V));
    NH = (normal.x*H.x) + (normal.y*H.y) + (normal.z*H.z);
    NHPow = pow(NH, 2.0);

    MatAmb = (0.1*texColor0).xyz;
    MatDif = (0.7*texColor0).xyz;
    MatSpec = (0.7*texColor0).xyz;

    //if(texColor0.b > texColor0.g && texColor0.b > texColor0.r){
    //    discard;
    //}

	//Outcolor = MatAmb + (dC*MatDif) + (NHPow*MatSpec);
    Outcolor = vec4(MatAmb + (dC*MatDif) + (NHPow*MatSpec), 1.0);
  
  	//to set the outcolor as the texture coordinate (for debugging)
	//Outcolor = vec4(vTexCoord.s, vTexCoord.t, 0, 1);
}

