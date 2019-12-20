Shader "Hidden/ambient/VacuumShaders/Subsurface Scattering/Transparent/Diffuse" 
{
	Properties 
	{
		[V_MaterialTag]
		_V_MaterialTag("", float) = 0

		//Default Options
		[V_MaterialTitle]
		_V_MaterialTitle_Default("Default Options", float) = 0


		_Color ("Main Color", Color) = (1,1,1,1)		
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		

		//Default Options
		[V_MaterialTitle]
		_V_MaterialTitle_SSS("Translucency Options", float) = 0

		[HideInInspector] _TransMap ("",2D) = "white" {}
		[HideInInspector] _TransColor ("", color) = (1, 1, 1, 1)
		[HideInInspector] _TransDistortion ("",Range(0,0.5)) = 0.1
		[HideInInspector] _TransPower("",Range(1.0,16.0)) = 1.0
		[HideInInspector] _TransScale("", Float) = 1.0
		[HideInInspector] _TransBackfaceIntensity("", Float) = 0.15

		[HideInInspector] _TransDirectianalLightStrength("", Range(0.0, 1.0)) = 0.2
		[HideInInspector] _TransOtherLightsStrength("", Range(0.0, 1.0)) = 0.5
		[HideInInspector] _V_SSS_Emission("", Float) = 0

		[HideInInspector] _V_SSS_Rim_Color("", color) = (1, 1, 1, 1)
		[HideInInspector] _V_SSS_Rim_Pow("", Range(0.5, 8.0)) = 2.0

	}
	SubShader  
	{
		Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" "SSSType"="Legacy/PixelLit"}
		LOD 200
		
		Pass 
		{
			ZWrite On
			ColorMask 0
		}
		
		CGPROGRAM		
		#pragma surface surf TransPhong nodynlightmap alpha:fade

		#pragma shader_feature V_SSS_NORMALIZE_DIFFUSE_COEF_OFF V_SSS_NORMALIZE_DIFFUSE_COEF_ON
		#pragma shader_feature V_SSS_ADVANCED_TRANSLUSENCY_OFF V_SSS_ADVANCED_TRANSLUSENCY_ON
		#pragma shader_feature V_SSS_RIM_OFF V_SSS_RIM_ON

		#include "../SSS.cginc"

		ENDCG
	}

	FallBack "Legacy Shaders/Transparent/Diffuse"
	CustomEditor "SubsurfaceScatteringMaterial_Editor"
}