//{"Values":["0","PPU/Fade","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.5","0","1"],"unique":1598}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1163.062\	211.4038\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			4\			0\	StereoUV\	348.0718\	101.5752\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	CameraInput\	633.5722\	73.57528\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			1\			2\	_FloatSlider\	418.072\	381.0753\	96\	50\		/Intensity\		/1\		/1598\		False\			null\			null\	Mul\	1000.072\	163.5752\	96\	110\		/4\		False\			null\			null\		True\			2\			3\		True\			5\			0\		False\			null\			null\	Custom\	799.0721\	222.0752\	96\	270\		/Assets/Post Processing Ultimate/Functions/Invert.hlsl\		/Invert\		/3\		/4\		/Value\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null

Shader "PPU/Fade" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			#include "../../Post Processing Ultimate/Functions/Invert.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz * Invert(half4(_Intensity, 0.0, 0.0, 0.0)).x);
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