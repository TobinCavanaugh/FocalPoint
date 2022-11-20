//{"Values":["0","PPU/SelectColor","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.7","0","1"],"unique":271}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":89.0},"name":"Color","selected":false,"Values":["Selected","Selected color","1","0","0","0"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	2021.709\	18.56354\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			12\			0\	CameraInput\	558.8506\	139.0396\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	394.5655\	47.61118\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	_Color\	390.3987\	415.1945\	96\	130\		/Selected\		/1\		/-1\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Sub\	782.8987\	325.1945\	96\	110\		/4\		False\			null\			null\		True\			3\			1\		True\			1\			0\		False\			null\			null\	Sub\	780.3987\	450.1945\	96\	110\		/4\		False\			null\			null\		True\			3\			2\		True\			1\			1\		False\			null\			null\	Sub\	752.8987\	571.445\	96\	110\		/4\		False\			null\			null\		True\			3\			3\		True\			1\			2\		False\			null\			null\	Abs\	944.1488\	323.9445\	96\	70\		False\			null\			null\		True\			4\			0\	Abs\	951.6488\	416.4445\	96\	70\		False\			null\			null\		True\			5\			0\	Abs\	950.3988\	573.9455\	96\	70\		False\			null\			null\		True\			6\			0\	Av\	1278.792\	426.4445\	96\	130\		/5\		False\			null\			null\		True\			7\			0\		True\			8\			0\		True\			9\			0\		False\			null\			null\	Av\	1217.363\	240.7302\	96\	130\		/5\		False\			null\			null\		True\			1\			0\		True\			1\			1\		True\			1\			2\		False\			null\			null\	Lerp\	1933.044\	225.9443\	96\	110\		False\			null\			null\		True\			1\			3\		True\			11\			0\		True\			16\			0\	Mul\	1471.447\	455.653\	96\	130\		/5\		False\			null\			null\		True\			14\			0\		True\			10\			0\		True\			17\			0\		False\			null\			null\	_FloatSlider\	1328.59\	587.082\	96\	50\		/Intensity\		/1\		/271\		False\			null\			null\	Pow\	1659.003\	469.01\	96\	90\		False\			null\			null\		True\			13\			0\		True\			17\			0\	Saturate\	1868\	443\	96\	70\		False\			null\			null\		True\			15\			0\	Value1\	1256\	666\	96\	50\		/4.0\		False\			null\			null

Shader "PPU/SelectColor" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			uniform half4 _Selected;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, ((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0), saturate(pow((_Intensity * ((abs((_Selected.x - SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x)) + abs((_Selected.y - SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y)) + abs((_Selected.z - SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z))) / 3.0) * 4.0), 4.0)));
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