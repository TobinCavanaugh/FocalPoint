//{"Values":["0","PPU/Blur","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"IntSlider","selected":false,"Values":["Iterations","Effect Iterations","4","1","16"],"unique":3980}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect Intensity","0.5","0","1"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":0,"Variable":1}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None","Iterations"]}
//\	CameraOutput\	2803.088\	499.3792\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\	StereoUV\	1339.316\	266.2101\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	CameraInput\	2264.046\	266.9483\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			10\			0\	Div\	2633.583\	358.5119\	96\	110\		/4\		False\			null\			null\		True\			5\			3\		True\			6\			0\		False\			null\			null\	Iterator\	276.2301\	702.7186\	96\	50\		False\			null\			null\	VarLoop3\	2476.808\	506.5282\	96\	190\		/0\		/0\		/0\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			3\		True\			6\			0\		False\			null\			null\	Value1\	1532.102\	779.5436\	96\	50\		/90.0\		False\			null\			null\	Div\	564.7683\	51.258\	96\	110\		/4\		False\			null\			null\		True\			20\			0\		True\			8\			0\		False\			null\			null\	Value1\	317.3644\	225.6875\	96\	50\		/3.0\		False\			null\			null\	Floor\	820.912\	81.06732\	96\	70\		False\			null\			null\		True\			7\			0\	Add\	2068.491\	237.1231\	96\	110\		/4\		False\			null\			null\		True\			1\			2\		True\			18\			0\		False\			null\			null\	Value1\	270.4833\	347.331\	96\	50\		/-0.003\		False\			null\			null\	Mod\	797.8412\	780.8055\	96\	110\		/4\		False\			null\			null\		True\			20\			0\		True\			8\			0\		False\			null\			null\	Value1\	518.3792\	915.2596\	96\	50\		/0.003\		False\			null\			null\	Add\	1452.466\	416.4485\	96\	110\		/4\		False\			null\			null\		True\			22\			0\		True\			16\			0\		False\			null\			null\	Add\	1664.248\	582.0057\	96\	110\		/4\		False\			null\			null\		True\			22\			0\		True\			17\			0\		False\			null\			null\	Mul\	1185.921\	112.8609\	96\	110\		/4\		False\			null\			null\		True\			9\			0\		True\			23\			0\		False\			null\			null\	Mul\	1410.65\	597.8945\	96\	110\		/4\		False\			null\			null\		True\			25\			0\		True\			23\			0\		False\			null\			null\	Mul\	1989.577\	760.9714\	96\	110\		/4\		False\			null\			null\		True\			19\			0\		True\			26\			0\		False\			null\			null\	_FloatSlider\	1458.51\	1034.186\	96\	50\		/Intensity\		/1\		/-1\		False\			null\			null\	Mod\	567.957\	443.3535\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			21\			0\		False\			null\			null\	Value1\	293.8383\	543.5024\	96\	50\		/9.0\		False\			null\			null\	Mul\	877.207\	360.1855\	96\	110\		/4\		False\			null\			null\		True\			11\			0\		True\			24\			0\		False\			null\			null\	Mul\	1025.849\	860.8287\	96\	110\		/4\		False\			null\			null\		True\			13\			0\		True\			24\			0\		False\			null\			null\	Div\	868.729\	616.8035\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			21\			0\		False\			null\			null\	Floor\	1162.419\	707.7026\	96\	70\		False\			null\			null\		True\			12\			0\	Append2\	1800.591\	433.9546\	96\	90\		False\			null\			null\		True\			15\			0\		True\			14\			0

Shader "PPU/Blur" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Iterations;
			uniform half _Intensity;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half IteratorVariable = 0.0;
				half3 var0 = 0.0;
				half3 CameraOutput = 0.0;
				for (IteratorVariable = 0.0; IteratorVariable < (0.0 + 90.0); ++IteratorVariable){
					var0 += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, (i.texcoordStereo + (_Intensity * half2(((-0.003 * (IteratorVariable / 9.0)) + (floor(((IteratorVariable % 9.0) % 3.0)) * (0.003 * (IteratorVariable / 9.0)))), ((-0.003 * (IteratorVariable / 9.0)) + (floor(((IteratorVariable % 9.0) / 3.0)) * (0.003 * (IteratorVariable / 9.0)))))))).xyz;
				}
				CameraOutput = (var0 / 90.0);
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