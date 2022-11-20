//{"Values":["0","PPU/ScanLines","_MainTex","0",""]}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Intensity","Effect intensity","0.5","0","1"],"unique":3352}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Width","Line width","0.5","0","1"],"unique":-1}|{"position":{"serializedVersion":"2","x":0.0,"y":0.0,"width":212.0,"height":109.0},"name":"FloatSlider","selected":false,"Values":["Gap","Gap between lines","0.5","0","1"],"unique":3249}|{"tempTextures":1,"passes":[{"position":{"serializedVersion":"2","x":0.0,"y":36.0,"width":212.0,"height":16.0},"Input":0,"Output":0,"Pass":0,"Iterations":1,"Variable":0}],"passOptions":["0"],"inputOptions":["Game","tempRT0"],"outputOptions":["Screen","tempRT0"],"variableOptions":["None"]}
//\	CameraOutput\	2107.509\	-44.59445\	96\	110\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			12\			0\	CameraInput\	1168.134\	-18.80869\	96\	170\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			2\			2\	StereoUV\	408.6091\	40.83392\	96\	90\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Mul\	1460.775\	98.78946\	96\	110\		/4\		False\			null\			null\		True\			1\			3\		True\			16\			0\		False\			null\			null\	Abs\	1280.12\	279.9202\	96\	70\		False\			null\			null\		True\			5\			0\	Sin\	1126.073\	294.9201\	96\	70\		False\			null\			null\		True\			6\			0\	Mul\	904.407\	266.5869\	96\	130\		/5\		False\			null\			null\		True\			8\			0\		True\			22\			0\		True\			7\			0\		False\			null\			null\	Value1\	672.0265\	390.9914\	96\	50\		/16.0\		False\			null\			null\	Add\	565.717\	174.5626\	96\	110\		/4\		False\			null\			null\		True\			2\			1\		True\			9\			0\		False\			null\			null\	Time\	255.8159\	227.2026\	96\	130\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Floor\	1476.172\	300.238\	96\	70\		False\			null\			null\		True\			11\			0\	Mul\	1369.226\	400.0096\	96\	110\		/4\		False\			null\			null\		True\			4\			0\		True\			20\			0\		False\			null\			null\	Lerp\	1634.388\	-54.22605\	96\	110\		False\			null\			null\		True\			1\			3\		True\			3\			0\		True\			15\			0\	Lerp\	1692.78\	416.7849\	96\	110\		False\			null\			null\		True\			10\			0\		True\			11\			0\		True\			14\			0\	Value1\	1490.279\	481.7843\	96\	50\		/0.5\		False\			null\			null\	_FloatSlider\	1856.279\	287.7852\	96\	50\		/Intensity\		/1\		/3352\		False\			null\			null\	Saturate\	1715.257\	273.1348\	96\	70\		False\			null\			null\		True\			13\			0\	_FloatSlider\	357.162\	554.1825\	96\	50\		/Width\		/2\		/-1\		False\			null\			null\	Value1\	517.162\	404.1825\	96\	50\		/1.1\		False\			null\			null\	Sub\	630.0195\	535.611\	96\	110\		/4\		False\			null\			null\		True\			18\			0\		True\			17\			0\		False\			null\			null\	Mul\	826.9835\	414.361\	96\	110\		/4\		False\			null\			null\		True\			7\			0\		True\			19\			0\		False\			null\			null\	_FloatSlider\	680.9725\	293.7062\	96\	50\		/Gap\		/3\		/3249\		False\			null\			null\	Sub\	861.627\	146.9799\	96\	110\		/4\		False\			null\			null\		True\			23\			0\		True\			21\			0\		False\			null\			null\	Value1\	667\	122.5555\	96\	50\		/2.0\		False\			null\			null

Shader "PPU/ScanLines" {

	HLSLINCLUDE

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			uniform half _Intensity;
			uniform half _Width;
			uniform half _Gap;

			half3 Frag0 (VaryingsDefault i) : SV_Target {
				half3 CameraOutput = 0.0;
				CameraOutput = lerp(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz, (SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoordStereo).xyz * saturate(lerp(floor((abs(sin(((i.texcoordStereo.y + _Time.x) * (2.0 - _Gap) * 16.0))) * (16.0 * (1.1 - _Width)))), (abs(sin(((i.texcoordStereo.y + _Time.x) * (2.0 - _Gap) * 16.0))) * (16.0 * (1.1 - _Width))), 0.5))), _Intensity);
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