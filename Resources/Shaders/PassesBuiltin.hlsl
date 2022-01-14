#ifndef DEARIMGUI_BUILTIN_INCLUDED
#define DEARIMGUI_BUILTIN_INCLUDED

#include "UnityCG.cginc"
#include "Packages/com.realgames.dear-imgui/Resources/Shaders/Common.hlsl"

sampler2D _Tex;

half4 unpack_color(uint c)
{
    half4 color = half4(
        (c      ) & 0xff,
        (c >>  8) & 0xff,
        (c >> 16) & 0xff,
        (c >> 24) & 0xff
    ) / 255;
    return color;
}

Varyings ImGuiPassVertex(ImVert input)
{
    Varyings output  = (Varyings)0;
    output.vertex    = UnityObjectToClipPos(float4(input.vertex, 0, 1));
    output.uv        = float2(input.uv.x, 1 - input.uv.y);
    output.color     = half4(GammaToLinearSpace(input.color.rgb), input.color.a);
    return output;
}

Varyings ImGuiPassPackedVertex(ImPackedVert input)
{
    ImVert output;
    output.vertex = input.vertex;
    output.uv = input.uv;
    output.color = unpack_color(input.color);
    return ImGuiPassVertex(output);
}

half4 ImGuiPassFrag(Varyings input) : SV_Target
{
    half4 fragColor = input.color * tex2D(_Tex, input.uv);
#ifdef UNITY_COLORSPACE_GAMMA
    fragColor.rgb = LinearToGammaSpace(input.color.rgb);
#endif
    return fragColor;
}

#endif
