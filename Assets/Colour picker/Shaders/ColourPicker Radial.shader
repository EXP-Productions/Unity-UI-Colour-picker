// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.34 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.34;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-9843-OUT;n:type:ShaderForge.SFN_TexCoord,id:4244,x:31663,y:32766,varname:node_4244,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:2028,x:31834,y:32766,varname:node_2028,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-4244-UVOUT;n:type:ShaderForge.SFN_ComponentMask,id:5873,x:32001,y:32766,varname:node_5873,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2028-OUT;n:type:ShaderForge.SFN_ArcTan2,id:6448,x:32174,y:32766,varname:node_6448,prsc:2,attp:2|A-5873-G,B-5873-R;n:type:ShaderForge.SFN_HsvToRgb,id:9843,x:32446,y:32822,varname:node_9843,prsc:2|H-6448-OUT,S-288-OUT,V-6516-OUT;n:type:ShaderForge.SFN_Slider,id:6516,x:32289,y:32971,ptovrint:False,ptlb:Value,ptin:_Value,varname:_Value_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Length,id:240,x:31874,y:32991,varname:node_240,prsc:2|IN-2028-OUT;n:type:ShaderForge.SFN_Clamp01,id:288,x:32045,y:32991,varname:node_288,prsc:2|IN-240-OUT;proporder:6516;pass:END;sub:END;*/

Shader "EXP/ColourPicker Radial" {
    Properties {
        _Value ("Value", Range(0, 1)) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Value;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float2 node_2028 = (i.uv0*2.0+-1.0);
                float2 node_5873 = node_2028.rg;
                float3 emissive = (lerp(float3(1,1,1),saturate(3.0*abs(1.0-2.0*frac(((atan2(node_5873.g,node_5873.r)/6.28318530718)+0.5)+float3(0.0,-1.0/3.0,1.0/3.0)))-1),saturate(length(node_2028)))*_Value);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
