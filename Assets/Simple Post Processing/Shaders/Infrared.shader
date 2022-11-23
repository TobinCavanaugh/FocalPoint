//{"Values":["0","PPU/Infrared","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.3","0","1"],"unique":-1}|{"tempTextures":0,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game"],"outputOptions":["Screen"],"variableOptions":["None"]}
//\	CameraOutput\	1550.026\	103.7812\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			5\			0\	CameraInput\	475.0263\	93.78112\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	290.0263\	81.78112\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Av\	643.276\	397.5316\	96\	130\		/5\		False\			null\			null\		True\			1\			0\		True\			1\			1\		True\			1\			2\		False\			null\			null\	_FloatSlider\	1071.804\	366.0876\	96\	50\		/Intensity\		/1\		/-1\		False\			null\			null\	Lerp\	1375.555\	316.0872\	96\	110\		False\			null\			null\		True\			1\			3\		True\			6\			3\		True\			4\			0\	Compare\	1085.554\	454.8372\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\		True\			9\			0\		True\			14\			0\		True\			7\			3\	Compare\	1361.555\	1106.338\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\		True\			10\			0\		True\			13\			0\		True\			8\			3\	Compare\	1338.804\	1588.338\	96\	230\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\		True\			11\			0\		True\			12\			0\		True\			11\			0\	Value1\	394.1254\	668.7656\	96\	50\		/0.33\		False\			null\			null\	Value1\	374.1254\	1877.516\	96\	50\		/0.66\		False\			null\			null\	Value1\	548.1615\	1709.588\	96\	50\		/1.0\		False\			null\			null\	Lerp\	1069.625\	1770.302\	96\	110\		False\			null\			null\		True\			20\			3\		True\			11\			0\		True\			22\			0\	Lerp\	1145.864\	1357.207\	96\	110\		False\			null\			null\		True\			17\			3\		True\			20\			3\		True\			19\			0\	Lerp\	1395.911\	850.0159\	96\	110\		False\			null\			null\		False\			null\			null\		True\			17\			3\		True\			15\			0\	Mul\	1094.483\	918.5874\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			16\			0\		False\			null\			null\	Value1\	308.1967\	1738.016\	96\	50\		/3.0\		False\			null\			null\	Value3\	1075.911\	770.0157\	96\	110\		/0.0\		/0.0\		/1.0\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Sub\	878.6731\	1238.064\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			9\			0\		False\			null\			null\	Mul\	960.6731\	1409.73\	96\	110\		/4\		False\			null\			null\		True\			18\			0\		True\			16\			0\		False\			null\			null\	Value3\	709.34\	1505.397\	96\	110\		/1.0\		/0.0\		/0.0\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Sub\	812.6736\	1777.897\	96\	110\		/4\		False\			null\			null\		True\			3\			0\		True\			10\			0\		False\			null\			null\	Mul\	926.6731\	1903.898\	96\	110\		/4\		False\			null\			null\		True\			21\			0\		True\			16\			0\		False\			null\			null

Shader "PPU/Infrared" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			float4 _Color;
			half _brightness;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				//CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) <= 0.33 ? lerp(0.0, half3(0.0, 0.0, 1.0), (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) * 3.0)) : (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) <= 0.66 ? lerp(half3(0.0, 0.0, 1.0), half3(1.0, 0.0, 0.0), ((((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) - 0.33) * 3.0)) : (((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) <= 1.0 ? lerp(half3(1.0, 0.0, 0.0), 1.0, ((((SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).x + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).y + SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).z) / 3.0) - 0.66) * 3.0)) : 1.0))), _Intensity);

				//Get the visuals from the camera (i think)
				CameraOutput = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo);

				CameraOutput *= _brightness;

				float val = _Color.w;

				_Color.x = (_Color.x + val)/2;
				_Color.y = (_Color.y + val)/2;
				_Color.z = (_Color.z + val)/2;

				//((CameraOutput+_Color)/2) * _Intensity;
				CameraOutput = lerp(CameraOutput, _Color, _Intensity);
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