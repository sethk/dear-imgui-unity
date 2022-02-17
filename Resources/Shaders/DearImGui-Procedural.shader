Shader "DearImGui/Procedural"
{
    // shader for Universal render pipeline
    SubShader
    {
        Tags { "RenderType" = "Transparent" "RenderPipeline" = "UniversalPipeline" "PreviewType" = "Plane" }
        LOD 100

        Lighting Off
        Cull Off ZWrite On ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Name "DEARIMGUI PROCEDURAL URP"

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment ImGuiPassFrag
            #pragma target 3.5
            #include "Packages/com.realgames.dear-imgui/Resources/Shaders/PassesUniversal.hlsl"

            StructuredBuffer<ImPackedVert> _Vertices;
            int _BaseVertex;

            Varyings vert(uint id : SV_VertexID)
            {
#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(SHADER_API_METAL)
                // BaseVertexLocation is not automatically added to SV_VertexID
                id += _BaseVertex;
#endif
                ImPackedVert v = _Vertices[id];
                return ImGuiPassPackedVertex(v);
            }
            ENDHLSL
        }
    }
	
	// shader for High Definition render pipeline
    SubShader
    {
        Tags { "RenderType" = "Transparent" "RenderPipeline" = "HDRenderPipeline" "PreviewType" = "Plane" }
        LOD 100

        Lighting Off
        Cull Off ZWrite On ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Name "DEARIMGUI PROCEDURAL HDRP"

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment ImGuiPassFrag
            #pragma target 3.5
            #include "Packages/com.realgames.dear-imgui/Resources/Shaders/PassesHighDefinition.hlsl"

            StructuredBuffer<ImVert> _Vertices;
            int _BaseVertex;

            Varyings vert(uint id : SV_VertexID)
            {
#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE)
                // BaseVertexLocation is not automatically added to SV_VertexID
                id += _BaseVertex;
#endif
                ImVert v = _Vertices[id];
                return ImGuiPassVertex(v);
            }
            ENDHLSL
        }
    }

    // shader for builtin rendering
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
        LOD 100

        Lighting Off
        Cull Off ZWrite On ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Name "DEARIMGUI PROCEDURAL BUILTIN"

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment ImGuiPassFrag
            #pragma target 3.5
            #include "Packages/com.realgames.dear-imgui/Resources/Shaders/PassesBuiltin.hlsl"

            StructuredBuffer<ImPackedVert> _Vertices;
            int _BaseVertex;

            Varyings vert(uint id : SV_VertexID)
            {
#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(SHADER_API_METAL)
                // BaseVertexLocation is not automatically added to SV_VertexID
                id += _BaseVertex;
#endif
                ImPackedVert v = _Vertices[id];
                return ImGuiPassPackedVertex(v);
            }
            ENDCG
        }
    }
}
