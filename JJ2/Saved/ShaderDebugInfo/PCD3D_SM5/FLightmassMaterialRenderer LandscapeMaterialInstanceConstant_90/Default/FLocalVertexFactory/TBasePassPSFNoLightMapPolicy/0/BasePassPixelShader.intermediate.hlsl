#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c48);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    float4 View_View_TemporalAAJitter : packoffset(c125);
    float4 View_View_ViewRectMin : packoffset(c128);
    float4 View_View_ViewSizeAndInvSize : packoffset(c129);
    float View_View_PreExposure : packoffset(c136.z);
    float View_View_OutOfBoundsMask : packoffset(c141);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c228.z);
};

ByteAddressBuffer View_PrimitiveSceneData;
cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[12] : packoffset(c0);
};

SamplerState View_MaterialTextureBilinearWrapedSampler;
SamplerState View_LandscapeWeightmapSampler;
Texture2D<float4> Material_Texture2D_0;
Texture2D<float4> Material_Texture2D_1;
Texture2D<float4> Material_Texture2D_2;
Texture2D<float4> Material_Texture2D_3;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD0[2];
static uint in_var_PRIMITIVE_ID;
static float4 in_var_VELOCITY_PREV_POS;
static float4 out_var_SV_Target0;
static float4 out_var_SV_Target4;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD0[2] : TEXCOORD0;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 in_var_VELOCITY_PREV_POS : VELOCITY_PREV_POS;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
    float4 out_var_SV_Target4 : SV_Target4;
};

static float4 _105 = 0.0f.xxxx;

void frag_main()
{
    float4 _144 = float4((((gl_FragCoord.xy - View_View_ViewRectMin.xy) * View_View_ViewSizeAndInvSize.zw) - 0.5f.xx) * float2(2.0f, -2.0f), gl_FragCoord.z, 1.0f) * (1.0f / gl_FragCoord.w);
    float4 _148 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _153 = (_148.xyz / _148.w.xxx) - View_View_RelativePreViewTranslation;
    float4 _157 = Material_Texture2D_0.Sample(View_LandscapeWeightmapSampler, in_var_TEXCOORD0[1].zw);
    float4 _171 = Material_Texture2D_1.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[2].x.xx);
    float4 _182 = Material_Texture2D_1.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[4].w.xx);
    float4 _195 = Material_Texture2D_2.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[6].w.xx);
    float _196 = _195.x;
    float4 _204 = Material_Texture2D_3.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125f.xx);
    float3 _205 = _204.xyz;
    float3 _212 = 1.0f.xxx - (((1.0f.xxx - _205) * 2.0f.xxx) * Material_Material_PreshaderBuffer[9].xyz);
    float3 _217 = (_205 * 2.0f.xxx) * Material_Material_PreshaderBuffer[8].xyz;
    uint _244 = in_var_PRIMITIVE_ID * 42u;
    float4 _301 = 0.0f.xxxx;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_244 * 16 + 0)).x) & 32u) != 0u)
    {
        float _254 = _144.w;
        float _270 = (_144.z / _254) - (in_var_VELOCITY_PREV_POS.z / in_var_VELOCITY_PREV_POS.w);
        float2 _274 = float3(((_144.xy / _254.xx) - View_View_TemporalAAJitter.xy) - ((in_var_VELOCITY_PREV_POS.xy / in_var_VELOCITY_PREV_POS.w.xx) - View_View_TemporalAAJitter.zw), _270).xy;
        float2 _284 = (((float2(int2(sign(_274))) * sqrt(abs(_274))) * 1.41421353816986083984375f).xy * 0.2495000064373016357421875f) + 0.49999237060546875f.xx;
        uint _286 = asuint(_270);
        float4 _293 = float4(_284.x, _284.y, _105.z, _105.w);
        _293.z = clamp((float((_286 >> 16u) & 65535u) * 1.525902189314365386962890625e-05f) + 1.525902234789100475609302520752e-06f, 0.0f, 1.0f);
        float4 _300 = _293;
        _300.w = clamp((float((_286 >> 0u) & 65535u) * 1.525902189314365386962890625e-05f) + 1.525902234789100475609302520752e-06f, 0.0f, 1.0f);
        _301 = _300;
    }
    else
    {
        _301 = 0.0f.xxxx;
    }
    float3 _302 = max(clamp((lerp(_171.xyz * Material_Material_PreshaderBuffer[4].xyz, _182.y.xxx * Material_Material_PreshaderBuffer[6].xyz, _196.xxx) * dot(_157, Material_Material_PreshaderBuffer[0]).xxx) + (lerp(float3((_204.x >= 0.5f) ? _212.x : _217.x, (_204.y >= 0.5f) ? _212.y : _217.y, (_204.z >= 0.5f) ? _212.z : _217.z), Material_Material_PreshaderBuffer[11].xyz, (_196 * 0.5f).xxx) * dot(_157, Material_Material_PreshaderBuffer[1]).xxx), 0.0f.xxx, 1.0f.xxx), 0.0f.xxx);
    float3 _361 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _333 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_244 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_153 - asfloat(View_PrimitiveSceneData.Load4((_244 + 19u) * 16 + 0)).xyz));
        float3 _334 = float3(asfloat(View_PrimitiveSceneData.Load4((_244 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_244 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_244 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _360 = 0.0f.xxx;
        if (any(bool3(_333.x > _334.x, _333.y > _334.y, _333.z > _334.z)))
        {
            float3 _339 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _340 = _153 * 0.57700002193450927734375f.xxx;
            float3 _356 = frac(frac(((_339.x + _339.y) + _339.z) * 4194.30419921875f) + (((_340.x + _340.y) + _340.z) * 0.00200000009499490261077880859375f)).xxx;
            _360 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_356.x > 0.5f.xxx.x, _356.y > 0.5f.xxx.y, _356.z > 0.5f.xxx.z)));
        }
        else
        {
            _360 = _302;
        }
        _361 = _360;
    }
    else
    {
        _361 = _302;
    }
    float4 _366 = float4(_361 * 1.0f, 0.0f);
    float4 _373 = 0.0f.xxxx;
    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
    {
        float4 _372 = _366;
        _372.w = 0.0f;
        _373 = _372;
    }
    else
    {
        _373 = _366;
    }
    float4 _375 = 0.0f.xxxx;
    _375.x = _301.x;
    float4 _377 = _375;
    _377.y = _301.y;
    float4 _379 = _377;
    _379.z = _301.z;
    float4 _381 = _379;
    _381.w = _301.w;
    out_var_SV_Target0 = _373 * View_View_PreExposure;
    out_var_SV_Target4 = _381;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    in_var_VELOCITY_PREV_POS = stage_input.in_var_VELOCITY_PREV_POS;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    stage_output.out_var_SV_Target4 = out_var_SV_Target4;
    return stage_output;
}
