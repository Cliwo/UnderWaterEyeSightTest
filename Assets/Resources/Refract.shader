Shader "Custom/Refract" {
	//http://tinkering.ee/unity/asset-unity-refractive-shader/
	Properties {
		_MainTex ("Main Texture", 2D) = "white"
		_Index ("Refractive Index", Float) = 1.25
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		LOD 100
		GrabPass{
			// "_BGTex"
			// if the name is assigned to the grab pass
			// all objects that use this shader also use a shared
			// texture grabbed before rendering them.
			// otherwise a new _GrabTexture will be created for each object.
		}
		Pass{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#include "UnityCG.cginc"
			
			struct appdata{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
			};

			struct v2f{
			float2 uv : TEXCOORD0;
			UNITY_FOG_COORDS(1)
			float4 vertex : SV_POSITION;
			float4 screenUV : TEXCOORD2;
			};

			float _Index;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			// builtin variable to get Grabbed Texture if GrabPass has no name
			sampler2D _GrabTexture;
			
			v2f vert (appdata v){
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			UNITY_TRANSFER_FOG(o,o.vertex);
			// builtin function to get screen coordinates for tex2Dproj()
			o.screenUV = ComputeGrabScreenPos(o.vertex);
			return o;
			}
			
			fixed4 frag (v2f i) : SV_Target{
		    float refractiveIndexInverse = 1.0 / _Index;
			fixed4 col = tex2D(_MainTex, i.uv);
			// sampled grab texture
			fixed4 grab = tex2Dproj(_GrabTexture, i.screenUV *float4(refractiveIndexInverse, refractiveIndexInverse, 1, 1));
			UNITY_APPLY_FOG(i.fogCoord, col);
			//return col;
			// visualize coordinates
			return grab;
			}
		ENDCG
	}

	}
	FallBack "Diffuse"
}
