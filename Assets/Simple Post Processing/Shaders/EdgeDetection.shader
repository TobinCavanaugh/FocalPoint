//{"Values":["0","PPU/EdgeDetection","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Edge","Edge Offset","0.5","0","1"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	3412.939\	-121.6012\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			20\			0\	CameraInput\	1528.415\	-9.053886\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	535.6882\	36.5804\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Add\	1196.073\	312.9834\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			16\			0\		False\			null\			null\	Sub\	1975.779\	153.0084\	96\	110\		/4\		False\			null\			null\		True\			1\			3\		True\			14\			0\		False\			null\			null\	Add\	1208.782\	167.6515\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			16\			0\		False\			null\			null\	Sub\	1134.637\	661.7104\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			16\			0\		False\			null\			null\	Sub\	1153\	476.5121\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			16\			0\		False\			null\			null\	_FloatSlider\	260.6679\	434.1185\	96\	50\		/Edge\		/1\		/-1\		False\			null\			null\	CameraInput\	1566.629\	217.9689\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			5\			0\		True\			3\			0\		False\			null\			null\	CameraInput\	1592.055\	466.0629\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			5\			0\		True\			3\			0\		False\			null\			null\	CameraInput\	1666.342\	682.251\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			6\			0\		True\			7\			0\		False\			null\			null\	CameraInput\	1624.914\	922.726\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			6\			0\		True\			7\			0\		False\			null\			null\	Add\	1910.904\	538.317\	96\	150\		/6\		False\			null\			null\		True\			9\			3\		True\			10\			3\		True\			11\			3\		True\			12\			3\		False\			null\			null\	Div\	2207.573\	563.3163\	96\	110\		/4\		False\			null\			null\		True\			13\			0\		True\			15\			0\		False\			null\			null\	Value1\	2029.236\	913.3125\	96\	50\		/4.0\		False\			null\			null\	Div\	743.2914\	222.1152\	96\	110\		/4\		False\			null\			null\		True\			8\			0\		True\			17\			0\		False\			null\			null\	Value1\	596.6235\	398.5579\	96\	50\		/300.0\		False\			null\			null\	Sub\	2274.239\	299.3733\	96\	110\		/4\		False\			null\			null\		True\			19\			0\		True\			4\			0\		False\			null\			null\	Value1\	1440.095\	-184.364\	96\	50\		/1.0\		False\			null\			null\	Mul\	3214.772\	-101.7878\	96\	110\		/4\		False\			null\			null\		True\			1\			3\		True\			22\			2\		False\			null\			null\	Av\	2767.701\	123.7657\	96\	130\		/5\		False\			null\			null\		True\			24\			0\		True\			24\			1\		True\			24\			2\		False\			null\			null\	Compare\	3010.201\	-20.12323\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			21\			0\		True\			23\			0\		False\			null\			null\		True\			19\			0\	Value1\	2630.035\	440.6542\	96\	50\		/0.9\		False\			null\			null\	Detach3\	2460.333\	218.9999\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			18\			0

Shader "PPU/EdgeDetection" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Edge;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz * ((((1.0 - (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz - ((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz) / 4.0))).x + (1.0 - (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz - ((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz) / 4.0))).y + (1.0 - (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz - ((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x + (_Edge / 300.0)),(i.texcoordStereo.y + (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, half2((i.texcoordStereo.x - (_Edge / 300.0)),(i.texcoordStereo.y - (_Edge / 300.0)))).xyz) / 4.0))).z) / 3.0) < 0.9 ? 0.0 : 1.0));
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