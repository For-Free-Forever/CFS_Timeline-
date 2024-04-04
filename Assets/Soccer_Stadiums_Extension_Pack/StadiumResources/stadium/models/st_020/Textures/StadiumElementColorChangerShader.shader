// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StadiumElementColorChangeShader"
{
	Properties
	{
		_ElementColor("ElementColor", Color) = (0.6981132,0.1350124,0.1350124,0)
		_BaseTexture("BaseTexture", 2D) = "white" {}
		_Metallic("Metallic", Float) = 0
		_Smoothness("Smoothness", Float) = 0
		_MaskingColor("MaskingColor", Color) = (0.4245283,0.4245283,0.4245283,0)
		_MaskThreshold("MaskThreshold", Float) = 0.076
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _ElementColor;
		uniform sampler2D _BaseTexture;
		uniform float4 _BaseTexture_ST;
		uniform float4 _MaskingColor;
		uniform float _MaskThreshold;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BaseTexture = i.uv_texcoord * _BaseTexture_ST.xy + _BaseTexture_ST.zw;
			float4 tex2DNode12 = tex2D( _BaseTexture, uv_BaseTexture );
			float4 lerpResult4 = lerp( _ElementColor , tex2DNode12 , ( 1.0 - saturate( ( 1.0 - ( ( distance( _MaskingColor.rgb , tex2DNode12.rgb ) - _MaskThreshold ) / max( 0.0 , 1E-05 ) ) ) ) ));
			float4 lerpResult11 = lerp( lerpResult4 , float4( 0,0,0,0 ) , float4( 0,0,0,0 ));
			o.Albedo = lerpResult11.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
80;281;1469;534;370.4857;240.3842;1.6;True;True
Node;AmplifyShaderEditor.ColorNode;20;-315.8695,-103.1403;Inherit;False;Property;_MaskingColor;MaskingColor;4;0;Create;True;0;0;0;False;0;False;0.4245283,0.4245283,0.4245283,0;0.5377357,0.5377357,0.5377357,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-99.43518,35.14587;Inherit;False;Property;_MaskThreshold;MaskThreshold;5;0;Create;True;0;0;0;False;0;False;0.076;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-415.8849,-305.6924;Inherit;True;Property;_BaseTexture;BaseTexture;1;0;Create;True;0;0;0;False;0;False;-1;None;25cbe6372f6ffc843ad462de197d6fc2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;19;34.89789,-149.7512;Inherit;True;Color Mask;-1;;1;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;382.5891,200.1706;Float;False;Property;_ElementColor;ElementColor;0;0;Create;True;0;0;0;False;0;False;0.6981132,0.1350124,0.1350124,0;0.3113207,0.3113207,0.3113207,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;8;215.8197,87.2999;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;4;431.6814,-199.576;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;11;669.5892,-263.496;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;790.9292,4.25449;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0;0.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;781.7606,116.8992;Inherit;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1078.941,-196.5984;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;StadiumElementColorChangeShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;1;12;0
WireConnection;19;3;20;0
WireConnection;19;4;21;0
WireConnection;8;0;19;0
WireConnection;4;0;10;0
WireConnection;4;1;12;0
WireConnection;4;2;8;0
WireConnection;11;0;4;0
WireConnection;0;0;11;0
WireConnection;0;3;17;0
WireConnection;0;4;18;0
ASEEND*/
//CHKSM=214183FA41996AC8612A3BC82595C58BF67C771E