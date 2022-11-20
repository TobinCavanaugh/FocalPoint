//{"Values":["0","Append2","_MainTex","0",""]}
//\	Output\	700\	152\	96\	110\		/1\		True\			1\			0\		True\			2\			0\		False\			null\			null\	Input1\	393\	93\	96\	70\		/X\		False\			null\			null\	Input1\	410\	282\	96\	70\		/Y\		False\			null\			null
//{"Name":"Append2","OutputSize":2,"InputSize":[1,1],"InputName":["Y","X"]}

half2 Append2(half1 Y, half1 X){
	half2 Output = 0.0;
	Output.x = X;
	Output.y = Y;
	return Output;
}