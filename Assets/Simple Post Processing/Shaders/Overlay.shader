//{"Values":["0","PPU/Overlay","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.5","0","1"],"unique":2557}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":69.0},"name":"Texture2D","selected":false,"Values":["Image","Overlay texture"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	997.5555\	63.41665\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	CameraInput\	608.5555\	72.41665\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	396.5556\	136.4167\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Texture2D\	574.5555\	279.4167\	96\	190\		/Image\		/1\		/-1\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	Lerp\	920.3055\	221.4167\	96\	110\		False\			null\			null\		True\			1\			3\		True\			3\			0\		True\			5\			0\	Mul\	813.75\	352.5001\	96\	110\		/4\		False\			null\			null\		True\			3\			4\		True\			6\			0\		False\			null\			null\	_FloatSlider\	676.25\	526.25\	96\	50\		/Intensity\		/1\		/2557\		False\			null\			null

Shader "PPU/Overlay" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			TEXTURE2D_SAMPLER2D(_Image, sampler_Image);

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, SAMPLE_TEXTURE2D(_Image, sampler_Image, i.texcoordStereo).xyz, (SAMPLE_TEXTURE2D(_Image, sampler_Image, i.texcoordStereo).w * _Intensity));
				return CameraOutput;
			}

	ENDHLSL

	SubShader {

		Cull Off ZWrite Off ZTest Always

		Pass {

			HLSLPROGRAM

				#pragma vertex VertDefault
				#pragma fragment Frag0

			ENDHLSL
		}
	}
}