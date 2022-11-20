//{"Values":["0","PPU/Frame","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Horizontal","Horizontal frame","0.5","0","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Vertical","Vertical frame","0.5","0","1"],"unique":2427}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	2133.078\	81.04774\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			12\			0\	CameraInput\	903.4125\	77.71425\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	394.2996\	98.82545\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Value1\	1074.188\	610.9354\	96\	50\		/0.0\		False\			null\			null\	Compare\	1644.078\	21.99196\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			7\			0\		True\			14\			0\		True\			3\			0\		True\			1\			3\	_FloatSlider\	1125.021\	731.3823\	96\	50\		/Horizontal\		/1\		/-1\		False\			null\			null\	_FloatSlider\	1110.8\	908.1073\	96\	50\		/Vertical\		/2\		/2427\		False\			null\			null\	Abs\	996.0774\	344.3809\	96\	70\		False\			null\			null\		True\			9\			0\	Value1\	352.9665\	275.4922\	96\	50\		/0.5\		False\			null\			null\	Sub\	792.2996\	317.7142\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			8\			0\		False\			null\			null\	Sub\	696.2996\	468.3794\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			8\			0\		False\			null\			null\	Abs\	1006.967\	487.7124\	96\	70\		False\			null\			null\		True\			10\			0\	Compare\	1914.915\	71.1581\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			11\			0\		True\			15\			0\		True\			3\			0\		True\			4\			0\	Custom\	1446.95\	547.3003\	96\	270\		/Assets/Post Processing Ultimate/Functions/Invert.hlsl\		/Invert\		/3\		/4\		/Value\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			5\			0\		True\			6\			0\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Div\	1679.506\	742.8024\	96\	110\		/4\		False\			null\			null\		True\			13\			0\		True\			16\			0\		False\			null\			null\	Div\	1839.507\	590.8043\	96\	110\		/4\		False\			null\			null\		True\			13\			1\		True\			16\			0\		False\			null\			null\	Value1\	1338.005\	888.8053\	96\	50\		/2.0\		False\			null\			null

Shader "PPU/Frame" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
			#include "../../Post Processing Ultimate/Functions/Invert.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Horizontal;
			uniform half _Vertical;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = (abs((i.texcoordStereo.y - 0.5)) > (Invert(half4(_Horizontal, _Vertical, 0.0, 0.0)).y / 2.0) ? 0.0 : (abs((i.texcoordStereo.x - 0.5)) > (Invert(half4(_Horizontal, _Vertical, 0.0, 0.0)).x / 2.0) ? 0.0 : SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz));
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