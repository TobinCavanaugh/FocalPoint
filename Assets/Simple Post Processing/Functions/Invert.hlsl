//{"Values":["0","Invert","_MainTex","0",""]}
//\	Output\	789\	295\	96\	150\		/3\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		True\			3\			0\	Input4\	326\	356\	96\	150\		/Value\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\		False\			null\			null\	Value1\	400\	250\	96\	50\		/1.0\		False\			null\			null\	Sub\	619\	408\	96\	110\		/4\		False\			null\			null\		True\			2\			0\		True\			1\			4\		False\			null\			null
//{"Name":"Invert","OutputSize":4,"InputSize":[4],"InputName":["Value"]}

half4 Invert(half4 Value){
	half4 Output = 0.0;
	Output = (1.0 - Value);
	return Output;
}