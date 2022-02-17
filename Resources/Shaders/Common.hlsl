#ifndef DEARIMGUI_COMMON_INCLUDED
#define DEARIMGUI_COMMON_INCLUDED

struct ImPackedVert   // same layout as ImDrawVert
{
    float2 vertex;
    float2 uv;
    uint   color;
};

struct ImVert
{
    float2 vertex   : POSITION;
    float2 uv       : TEXCOORD0;
    half4  color    : TEXCOORD1; // gets reordered when using COLOR semantics
};

struct Varyings
{
    float4 vertex   : SV_POSITION;
    float2 uv       : TEXCOORD0;
    half4  color    : COLOR;
};

#endif
