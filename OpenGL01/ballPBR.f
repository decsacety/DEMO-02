#version 460

in vec2 Tex;
in vec3 Pos;
in vec3 Norm;

#define PI 3.14159265
#define L_Num 2

out vec4 fragcolor;

uniform sampler2D Envir;
uniform vec3 lightPos;
uniform vec3 cameraPos;
uniform vec3 lightColor;//��ǿ
uniform float rough;//�ֲڶ�
uniform float Freh;//����������ϵ��
uniform float L_C;//��˥��ϵ��
uniform vec3 light02Pos;//����Դλ��
uniform vec3 light02Col;//����Դ��ǿ
uniform float L_C02;//����Դ˥��ϵ��

//���߷ֲ�����
float D_GGX_TR(vec3 N, vec3 H, float a)
{
    float a2     = a*a;
    float NdotH  = max(dot(N, H),0.0001);
    float NdotH2 = NdotH*NdotH;

    float denom  = (NdotH2 * (a2 - 1.0f) + 1.0f);
    denom        = PI * denom * denom;

    return a2 / denom;
}
//���κ���
float GeometrySchlickGGX(float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r*r) / 8.0;

    float nom   = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return nom / denom;
}
float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness)
{
    float NdotV = max(dot(N, V), 0.0);
    float NdotL = max(dot(N, L), 0.0);
    float ggx2 = GeometrySchlickGGX(NdotV, roughness);
    float ggx1 = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}
//������ϵ������
vec3 fresnelSchlick(float cosTheta, vec3 F0)
{
    return F0 + (1.0 - F0) * pow(max(1.0 - cosTheta, 0.0), 5.0);
}
void main()
{
    vec3 N = normalize(Norm);//�����������������귨�߱�׼��
    vec3 ViewDir = normalize(cameraPos - Pos);

    vec3 LightPos[L_Num] = {lightPos, light02Pos};
    vec3 LightCol[L_Num] = {lightColor, light02Col};
    float LC[L_Num] = {L_C, L_C02};
    vec3 Lcol = vec3(0.0f,0.0f,0.0f);
    for(int i=0;i<L_Num;i++)
    {
        vec3 lightDir = normalize(LightPos[i] - Pos);
        vec3 H = normalize(ViewDir + lightDir);
        
        vec3 F0 = vec3(Freh); 
        float distance = length(LightPos[i] - Pos);
        
        float attenuation = LC[i] / (distance * distance);//��˥��ϵ��
        vec3 radiance = LightCol[i] * attenuation;//˥�����ǿ
        //����Cook-Torrance BRDF�е�DFG
	    float D = D_GGX_TR(Norm, lightDir, rough);
        vec3 F = fresnelSchlick(clamp(dot(H, ViewDir),0.0f, 1.0f), F0);
        float G = GeometrySmith(N ,ViewDir ,lightDir , rough);//���ݳ��䷽�����䷽�򣬷��ߺʹֲڶȷ��ع���ֵ
        
        vec3 nominator    = D * G * F;
        float denominator = 4.0 * max(dot(N, ViewDir), 0.0) * max(dot(N, lightDir), 0.0) + 0.001; 
        vec3 specular     = nominator / denominator;  
        
        vec3 KD = vec3(1.0f) - F;
        
        float NdotL = max(dot(N, lightDir), 0.0);
        Lcol += (KD/PI + specular) * radiance * NdotL; //* radiance
    }

	vec3 ambientCol = texture(Envir, Tex).rgb;
    vec3 tmp = Lcol + ambientCol;
    //tmp = tmp / (tmp + vec3(1.0));
    //tmp = pow(tmp, vec3(1.0/2.2)); 
    //vec3 tmp =  col*F;
    //col*G*D*F + col*0.5 +
	fragcolor = vec4(tmp, 1.0f);
}