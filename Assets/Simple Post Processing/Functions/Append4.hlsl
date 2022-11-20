//{"Values":["0","Append4","_MainTex","0",""]}
//\	Output\	701\	160\	96\	150\		/3\		True\			1\			0\		True\			2\			0\		True\			3\			0\		True\			4\			0\		False\			null\			null\	Input1\	381\	65\	96\	70\		/X\		False\			null\			null\	Input1\	373\	176\	96\	70\		/Y\		False\			null\			null\	Input1\	375\	279\	96\	70\		/Z\		False\			null\			null\	Input1\	383\	385\	96\	70\		/W\		False\			null\			null
//{"Name":"Append4","OutputSize":4,"InputSize":[1,1,1,1],"InputName":["W","Z","Y","X"]}

half4 Append4(half1 W, half1 Z, half1 Y, half1 X){
	half4 Output = 0.0;
	Output.x = X;
	Output.y = Y;
	Output.z = Z;
	Output.w = W;
	return Output;
}