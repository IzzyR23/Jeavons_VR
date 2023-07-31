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
    float View_View_MaterialTextureMipBias : packoffset(c144);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c228.z);
};

ByteAddressBuffer View_PrimitiveSceneData;
cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[10] : packoffset(c0);
};

SamplerState View_MaterialTextureBilinearWrapedSampler;
SamplerState View_LandscapeWeightmapSampler;
Texture2D<float4> Material_Texture2D_0;
Texture2D<float4> Material_Texture2D_1;
Texture2D<float4> Material_Texture2D_2;
Texture2D<float4> Material_Texture2D_3;
Texture2D<float4> Material_Texture2D_4;
SamplerState Material_Texture2D_4Sampler;

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

static float4 _102 = 0.0f.xxxx;

void frag_main()
{
    float4 _142 = float4((((gl_FragCoord.xy - View_View_ViewRectMin.xy) * View_View_ViewSizeAndInvSize.zw) - 0.5f.xx) * float2(2.0f, -2.0f), gl_FragCoord.z, 1.0f) * (1.0f / gl_FragCoord.w);
    float4 _146 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _151 = (_146.xyz / _146.w.xxx) - View_View_RelativePreViewTranslation;
    float4 _155 = Material_Texture2D_0.Sample(View_LandscapeWeightmapSampler, in_var_TEXCOORD0[1].zw);
    float4 _172 = Material_Texture2D_1.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[3].x.xx);
    float4 _183 = Material_Texture2D_1.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[5].w.xx);
    float4 _196 = Material_Texture2D_2.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * Material_Material_PreshaderBuffer[7].w.xx);
    float4 _204 = Material_Texture2D_3.Sample(View_MaterialTextureBilinearWrapedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float4 _219 = Material_Texture2D_4.SampleBias(Material_Texture2D_4Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5f.xx, View_View_MaterialTextureMipBias);
    uint _225 = in_var_PRIMITIVE_ID * 42u;
    float4 _282 = 0.0f.xxxx;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_225 * 16 + 0)).x) & 32u) != 0u)
    {
        float _235 = _142.w;
        float _251 = (_142.z / _235) - (in_var_VELOCITY_PREV_POS.z / in_var_VELOCITY_PREV_POS.w);
        float2 _255 = float3(((_142.xy / _235.xx) - View_View_TemporalAAJitter.xy) - ((in_var_VELOCITY_PREV_POS.xy / in_var_VELOCITY_PREV_POS.w.xx) - View_View_TemporalAAJitter.zw), _251).xy;
        float2 _265 = (((float2(int2(sign(_255))) * sqrt(abs(_255))) * 1.41421353816986083984375f).xy * 0.2495000064373016357421875f) + 0.49999237060546875f.xx;
        uint _267 = asuint(_251);
        float4 _274 = float4(_265.x, _265.y, _102.z, _102.w);
        _274.z = clamp((float((_267 >> 16u) & 65535u) * 1.525902189314365386962890625e-05f) + 1.525902234789100475609302520752e-06f, 0.0f, 1.0f);
        float4 _281 = _274;
        _281.w = clamp((float((_267 >> 0u) & 65535u) * 1.525902189314365386962890625e-05f) + 1.525902234789100475609302520752e-06f, 0.0f, 1.0f);
        _282 = _281;
    }
    else
    {
        _282 = 0.0f.xxxx;
    }
    float3 _283 = max(clamp(((lerp(_172.xyz * Material_Material_PreshaderBuffer[5].xyz, _183.y.xxx * Material_Material_PreshaderBuffer[7].xyz, _196.x.xxx) * dot(_155, Material_Material_PreshaderBuffer[0]).xxx) + (min(Material_Material_PreshaderBuffer[9].xyz, _204.xyz) * dot(_155, Material_Material_PreshaderBuffer[1]).xxx)) + (_219.xyz * dot(_155, Material_Material_PreshaderBuffer[2]).xxx), 0.0f.xxx, 1.0f.xxx), 0.0f.xxx);
    float3 _342 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _314 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_225 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_151 - asfloat(View_PrimitiveSceneData.Load4((_225 + 19u) * 16 + 0)).xyz));
        float3 _315 = float3(asfloat(View_PrimitiveSceneData.Load4((_225 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_225 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_225 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _341 = 0.0f.xxx;
        if (any(bool3(_314.x > _315.x, _314.y > _315.y, _314.z > _315.z)))
        {
            float3 _320 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _321 = _151 * 0.57700002193450927734375f.xxx;
            float3 _337 = frac(frac(((_320.x + _320.y) + _320.z) * 4194.30419921875f) + (((_321.x + _321.y) + _321.z) * 0.00200000009499490261077880859375f)).xxx;
            _341 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_337.x > 0.5f.xxx.x, _337.y > 0.5f.xxx.y, _337.z > 0.5f.xxx.z)));
        }
        else
        {
            _341 = _283;
        }
        _342 = _341;
    }
    else
    {
        _342 = _283;
    }
    float4 _347 = float4(_342 * 1.0f, 0.0f);
    float4 _354 = 0.0f.xxxx;
    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
    {
        float4 _353 = _347;
        _353.w = 0.0f;
        _354 = _353;
    }
    else
    {
        _354 = _347;
    }
    float4 _356 = 0.0f.xxxx;
    _356.x = _282.x;
    float4 _358 = _356;
    _358.y = _282.y;
    float4 _360 = _358;
    _360.z = _282.z;
    float4 _362 = _360;
    _362.w = _282.w;
    out_var_SV_Target0 = _354 * View_View_PreExposure;
    out_var_SV_Target4 = _362;
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
