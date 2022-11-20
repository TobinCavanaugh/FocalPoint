//{"Values":["0","Append3","_MainTex","0",""]}
//\	Output\	802\	173.6667\	96\	130\		/2\		True\			1\			0\		True\			2\			0\		True\			3\			0\		False\			null\			null\	Input1\	417\	94.3333\	96\	70\		/X\		False\			null\			null\	Input1\	348.6665\	272.6667\	96\	70\		/Y\		False\			null\			null\	Input1\	492.333\	419.6666\	96\	70\		/Z\		False\			null\			null
//{"Name":"Append3","OutputSize":3,"InputSize":[1,1,1],"InputName":["Z","Y","X"]}

half3 Append3(half1 Z, half1 Y, half1 X){
	half3 Output = 0.0;
	Output.x = X;
	Output.y = Y;
	Output.z = Z;
	return Output;
}