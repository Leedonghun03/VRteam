﻿Shader "Test/RimLight" {
	Properties{
	  _Color("Color", Color) = (1,1,1,1)
	  _MainTex("Texture", 2D) = "white" {}
	  _RimColor("Rim Color", Color) = (0.26,0.19,0.16,0.0)
	  _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
	}
		SubShader{
		  Tags { "RenderType" = "Opaque" }
		  CGPROGRAM
		  #pragma surface surf Lambert
		  struct Input {
			  float2 uv_MainTex;
			  float3 viewDir;
		  };

		  sampler2D _MainTex;
		  float4 _RimColor;
		  float _RimPower;
		  fixed4 _Color;

		  void surf(Input IN, inout SurfaceOutput o) {	
			  half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			  o.Emission = _RimColor.rgb * pow(rim, _RimPower);		
			  fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			  o.Albedo = c.rgb;
		  }
		  ENDCG
	  }
		  Fallback "Diffuse"
}