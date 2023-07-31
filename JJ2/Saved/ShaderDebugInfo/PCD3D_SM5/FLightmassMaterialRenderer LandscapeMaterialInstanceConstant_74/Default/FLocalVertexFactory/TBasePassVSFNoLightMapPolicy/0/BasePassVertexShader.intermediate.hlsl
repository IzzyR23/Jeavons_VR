#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    row_major float4x4 View_View_PrevTranslatedWorldToClip : packoffset(c85);
    float3 View_View_RelativePrevPreViewTranslation : packoffset(c108);
    uint View_View_InstanceSceneDataSOAStride : packoffset(c283);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_InstanceSceneData;
ByteAddressBuffer View_InstancePayloadData;
ByteAddressBuffer InstanceCulling_InstanceIdsBuffer;
cbuffer LocalVF
{
    int4 LocalVF_LocalVF_VertexFetch_Parameters : packoffset(c0);
};

Buffer<float4> LocalVF_VertexFetch_TexCoordBuffer;
Buffer<float4> LocalVF_VertexFetch_PackedTangentsBuffer;

static float4 gl_Position;
static int gl_VertexIndex;
static int gl_InstanceIndex;
static float4 in_var_ATTRIBUTE0;
static uint in_var_ATTRIBUTE13;
static float4 out_var_TEXCOORD10_centroid;
static float4 out_var_TEXCOORD11_centroid;
static float4 out_var_TEXCOORD0[2];
static uint out_var_PRIMITIVE_ID;
static float4 out_var_VELOCITY_PREV_POS;

struct SPIRV_Cross_Input
{
    float4 in_var_ATTRIBUTE0 : ATTRIBUTE0;
    uint in_var_ATTRIBUTE13 : ATTRIBUTE13;
    uint gl_VertexIndex : SV_VertexID;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float4 out_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 out_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 out_var_TEXCOORD0[2] : TEXCOORD0;
    nointerpolation uint out_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 out_var_VELOCITY_PREV_POS : VELOCITY_PREV_POS;
    precise float4 gl_Position : SV_Position;
};

static float3x3 _109 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);

void vert_main()
{
    float3 _126 = -View_View_ViewTilePosition;
    uint _145 = 0u;
    if ((in_var_ATTRIBUTE13 & 2147483648u) != 0u)
    {
        _145 = uint(int(asuint(asfloat(View_PrimitiveSceneData.Load4(((in_var_ATTRIBUTE13 & 2147483647u) * 42u) * 16 + 0)).y))) + uint(gl_InstanceIndex);
    }
    else
    {
        _145 = InstanceCulling_InstanceIdsBuffer.Load((in_var_ATTRIBUTE13 + uint(gl_InstanceIndex)) * 4 + 0) & 268435455u;
    }
    uint _151 = asuint(asfloat(View_InstanceSceneData.Load4(_145 * 16 + 0)).x);
    uint _153 = (_151 >> 0u) & 1048575u;
    uint _155 = (_151 >> 20u) & 4095u;
    float3 _495 = 0.0f.xxx;
    float4x4 _496 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float3 _497 = 0.0f.xxx;
    float4x4 _498 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float _499 = 0.0f;
    [branch]
    if (false || (_153 != 1048575u))
    {
        uint _165 = _153 * 42u;
        uint _190 = ((_155 & 8u) != 0u) ? (((((asuint(asfloat(View_InstanceSceneData.Load4(_145 * 16 + 0)).y) >> 0u) & 16777215u) * asuint(asfloat(View_PrimitiveSceneData.Load4((_165 + 28u) * 16 + 0)).w)) + asuint(asfloat(View_PrimitiveSceneData.Load4((_165 + 27u) * 16 + 0)).w)) + (((_155 & 64u) != 0u) ? 2u : uint(((_155 & 32u) != 0u) || ((_155 & 128u) != 0u)))) : 4294967295u;
        uint4 _198 = asuint(asfloat(View_InstanceSceneData.Load4((View_View_InstanceSceneDataSOAStride + _145) * 16 + 0)));
        uint _200 = (2u * View_View_InstanceSceneDataSOAStride) + _145;
        float4x4 _204 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _204[3] = float4(asfloat(View_InstanceSceneData.Load4(_200 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_200 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_200 * 16 + 0)).z, 0.0f.xxxx.w);
        float4x4 _205 = _204;
        _205[3].w = 1.0f;
        uint _206 = _198.x;
        uint _213 = _198.y;
        float _216 = float((_213 >> 0u) & 32767u);
        float2 _220 = (float3(float((_206 >> 0u) & 65535u), float((_206 >> 16u) & 65535u), _216).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _222 = (_216 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
        bool _224 = (_213 & 32768u) != 0u;
        float _225 = _220.x;
        float _226 = _220.y;
        float _227 = _225 + _226;
        float _228 = _225 - _226;
        float3 _234 = normalize(float3(_227, _228, 2.0f - dot(1.0f.xx, abs(float2(_227, _228)))));
        float4 _235 = float4(_234.x, _234.y, _234.z, 0.0f.xxxx.w);
        float4x4 _236 = _205;
        _236[2] = _235;
        float _239 = 1.0f / (1.0f + _234.z);
        float _240 = _234.x;
        float _241 = -_240;
        float _242 = _234.y;
        float _244 = (_241 * _242) * _239;
        float _256 = sqrt(1.0f - (_222 * _222));
        float3 _261 = (float3(1.0f - ((_240 * _240) * _239), _244, _241) * (_224 ? _222 : _256)) + (float3(_244, 1.0f - ((_242 * _242) * _239), -_242) * (_224 ? _256 : _222));
        float4 _262 = float4(_261.x, _261.y, _261.z, 0.0f.xxxx.w);
        float4x4 _263 = _236;
        _263[0] = _262;
        float3 _266 = cross(_234.xyz, _261.xyz);
        float4 _267 = float4(_266.x, _266.y, _266.z, 0.0f.xxxx.w);
        float4x4 _268 = _263;
        _268[1] = _267;
        uint _269 = _198.w;
        uint _274 = _198.z;
        float3 _282 = (float3(uint3(_274 >> 0u, _274 >> 16u, _269 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_269 >> 16u) - 15u) << 23u);
        float4x4 _285 = _268;
        _285[0] = _262 * _282.x;
        float4x4 _288 = _285;
        _288[1] = _267 * _282.y;
        float4x4 _291 = _288;
        _291[2] = _235 * _282.z;
        uint4 _296 = asuint(asfloat(View_InstanceSceneData.Load4(((3u * View_View_InstanceSceneDataSOAStride) + _145) * 16 + 0)));
        uint _298 = (4u * View_View_InstanceSceneDataSOAStride) + _145;
        float4x4 _302 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _302[3] = float4(asfloat(View_InstanceSceneData.Load4(_298 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_298 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_298 * 16 + 0)).z, 0.0f.xxxx.w);
        float4x4 _303 = _302;
        _303[3].w = 1.0f;
        uint _304 = _296.x;
        uint _311 = _296.y;
        float _314 = float((_311 >> 0u) & 32767u);
        float2 _318 = (float3(float((_304 >> 0u) & 65535u), float((_304 >> 16u) & 65535u), _314).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _320 = (_314 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
        bool _322 = (_311 & 32768u) != 0u;
        float _323 = _318.x;
        float _324 = _318.y;
        float _325 = _323 + _324;
        float _326 = _323 - _324;
        float3 _332 = normalize(float3(_325, _326, 2.0f - dot(1.0f.xx, abs(float2(_325, _326)))));
        float4 _333 = float4(_332.x, _332.y, _332.z, 0.0f.xxxx.w);
        float4x4 _334 = _303;
        _334[2] = _333;
        float _337 = 1.0f / (1.0f + _332.z);
        float _338 = _332.x;
        float _339 = -_338;
        float _340 = _332.y;
        float _342 = (_339 * _340) * _337;
        float _354 = sqrt(1.0f - (_320 * _320));
        float3 _359 = (float3(1.0f - ((_338 * _338) * _337), _342, _339) * (_322 ? _320 : _354)) + (float3(_342, 1.0f - ((_340 * _340) * _337), -_340) * (_322 ? _354 : _320));
        float4 _360 = float4(_359.x, _359.y, _359.z, 0.0f.xxxx.w);
        float4x4 _361 = _334;
        _361[0] = _360;
        float3 _364 = cross(_332.xyz, _359.xyz);
        float4 _365 = float4(_364.x, _364.y, _364.z, 0.0f.xxxx.w);
        float4x4 _366 = _361;
        _366[1] = _365;
        uint _367 = _296.w;
        uint _372 = _296.z;
        float3 _380 = (float3(uint3(_372 >> 0u, _372 >> 16u, _367 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_367 >> 16u) - 15u) << 23u);
        float4x4 _383 = _366;
        _383[0] = _360 * _380.x;
        float4x4 _386 = _383;
        _386[1] = _365 * _380.y;
        float4x4 _389 = _386;
        _389[2] = _333 * _380.z;
        float4x4 _494 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        [branch]
        if (_190 != 4294967295u)
        {
            uint4 _401 = asuint(asfloat(View_InstancePayloadData.Load4(_190 * 16 + 0)));
            uint _402 = _190 + 1u;
            float4x4 _406 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
            _406[3] = float4(asfloat(View_InstancePayloadData.Load4(_402 * 16 + 0)).x, asfloat(View_InstancePayloadData.Load4(_402 * 16 + 0)).y, asfloat(View_InstancePayloadData.Load4(_402 * 16 + 0)).z, 0.0f.xxxx.w);
            float4x4 _407 = _406;
            _407[3].w = 1.0f;
            uint _408 = _401.x;
            uint _415 = _401.y;
            float _418 = float((_415 >> 0u) & 32767u);
            float2 _422 = (float3(float((_408 >> 0u) & 65535u), float((_408 >> 16u) & 65535u), _418).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
            float _424 = (_418 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
            bool _426 = (_415 & 32768u) != 0u;
            float _427 = _422.x;
            float _428 = _422.y;
            float _429 = _427 + _428;
            float _430 = _427 - _428;
            float3 _436 = normalize(float3(_429, _430, 2.0f - dot(1.0f.xx, abs(float2(_429, _430)))));
            float4 _437 = float4(_436.x, _436.y, _436.z, 0.0f.xxxx.w);
            float4x4 _438 = _407;
            _438[2] = _437;
            float _441 = 1.0f / (1.0f + _436.z);
            float _442 = _436.x;
            float _443 = -_442;
            float _444 = _436.y;
            float _446 = (_443 * _444) * _441;
            float _458 = sqrt(1.0f - (_424 * _424));
            float3 _463 = (float3(1.0f - ((_442 * _442) * _441), _446, _443) * (_426 ? _424 : _458)) + (float3(_446, 1.0f - ((_444 * _444) * _441), -_444) * (_426 ? _458 : _424));
            float4 _464 = float4(_463.x, _463.y, _463.z, 0.0f.xxxx.w);
            float4x4 _465 = _438;
            _465[0] = _464;
            float3 _468 = cross(_436.xyz, _463.xyz);
            float4 _469 = float4(_468.x, _468.y, _468.z, 0.0f.xxxx.w);
            float4x4 _470 = _465;
            _470[1] = _469;
            uint _471 = _401.w;
            uint _476 = _401.z;
            float3 _484 = (float3(uint3(_476 >> 0u, _476 >> 16u, _471 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_471 >> 16u) - 15u) << 23u);
            float4x4 _487 = _470;
            _487[0] = _464 * _484.x;
            float4x4 _490 = _487;
            _490[1] = _469 * _484.y;
            float4x4 _493 = _490;
            _493[2] = _437 * _484.z;
            _494 = _493;
        }
        else
        {
            _494 = _389;
        }
        _495 = 1.0f.xxx / abs(_282).xyz;
        _496 = _291;
        _497 = asfloat(View_PrimitiveSceneData.Load4((_165 + 1u) * 16 + 0)).xyz;
        _498 = _494;
        _499 = ((_155 & 1u) != 0u) ? (-1.0f) : 1.0f;
    }
    else
    {
        _495 = 0.0f.xxx;
        _496 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _497 = 0.0f.xxx;
        _498 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _499 = 0.0f;
    }
    uint _508 = uint(LocalVF_LocalVF_VertexFetch_Parameters.w) + uint(gl_VertexIndex);
    uint _509 = 2u * _508;
    float4 _514 = LocalVF_VertexFetch_PackedTangentsBuffer.Load(_509 + 1u);
    float _515 = _514.w;
    float3 _516 = _514.xyz;
    float3 _518 = cross(_516, LocalVF_VertexFetch_PackedTangentsBuffer.Load(_509).xyz) * _515;
    float3x3 _521 = _109;
    _521[0] = cross(_518, _516) * _515;
    float3x3 _522 = _521;
    _522[1] = _518;
    float3x3 _523 = _522;
    _523[2] = _516;
    float3x3 _533 = float3x3(_496[0].xyz, _496[1].xyz, _496[2].xyz);
    _533[0] = _496[0].xyz * _495.x;
    float3x3 _536 = _533;
    _536[1] = _496[1].xyz * _495.y;
    float3x3 _539 = _536;
    _539[2] = _496[2].xyz * _495.z;
    float3x3 _540 = mul(_523, _539);
    float3 _543 = in_var_ATTRIBUTE0.xxx * _496[0].xyz;
    float3 _545 = in_var_ATTRIBUTE0.yyy * _496[1].xyz;
    float3 _546 = _543 + _545;
    float3 _548 = in_var_ATTRIBUTE0.zzz * _496[2].xyz;
    float3 _549 = _546 + _548;
    float3 _552 = _497 + _126;
    float3 _553 = _496[3].xyz + View_View_RelativePreViewTranslation;
    float3 _554 = _552 * 2097152.0f;
    float3 _555 = _554 + _553;
    float3 _556 = _549 + _555;
    float _557 = _556.x;
    float _558 = _556.y;
    float _559 = _556.z;
    float4 _560 = float4(_557, _558, _559, 1.0f);
    uint _563 = uint(LocalVF_LocalVF_VertexFetch_Parameters.y);
    uint _564 = _563 - 1u;
    uint _566 = _563 * _508;
    float4 _569 = LocalVF_VertexFetch_TexCoordBuffer.Load(_566 + min(0u, _564));
    float4 _572 = LocalVF_VertexFetch_TexCoordBuffer.Load(_566 + min(1u, _564));
    float4 _575 = LocalVF_VertexFetch_TexCoordBuffer.Load(_566 + min(2u, _564));
    float4 _578 = LocalVF_VertexFetch_TexCoordBuffer.Load(_566 + min(3u, _564));
    float4 _579 = float4(_560.x, _560.y, _560.z, _560.w);
    float4 _580 = mul(_579, View_View_TranslatedWorldToClip);
    float4 _593[2] = { float4(_569.x, _569.y, _572.x, _572.y), float4(_575.x, _575.y, _578.x, _578.y) };
    float4 _619 = 0.0f.xxxx;
    [flatten]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4((_153 * 42u) * 16 + 0)).x) & 32u) != 0u)
    {
        _619 = mul(float4((((in_var_ATTRIBUTE0.xxx * _498[0].xyz) + (in_var_ATTRIBUTE0.yyy * _498[1].xyz)) + (in_var_ATTRIBUTE0.zzz * _498[2].xyz)) + (_554 + (_498[3].xyz + View_View_RelativePrevPreViewTranslation)), 1.0f), View_View_PrevTranslatedWorldToClip);
    }
    else
    {
        _619 = float4(0.0f, 0.0f, 0.0f, 1.0f);
    }
    out_var_TEXCOORD10_centroid = float4(_540[0], 0.0f);
    out_var_TEXCOORD11_centroid = float4(_540[2], _515 * _499);
    out_var_TEXCOORD0 = _593;
    out_var_PRIMITIVE_ID = _153;
    out_var_VELOCITY_PREV_POS = _619;
    gl_Position = _580;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
    in_var_ATTRIBUTE0 = stage_input.in_var_ATTRIBUTE0;
    in_var_ATTRIBUTE13 = stage_input.in_var_ATTRIBUTE13;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.out_var_TEXCOORD10_centroid = out_var_TEXCOORD10_centroid;
    stage_output.out_var_TEXCOORD11_centroid = out_var_TEXCOORD11_centroid;
    stage_output.out_var_TEXCOORD0 = out_var_TEXCOORD0;
    stage_output.out_var_PRIMITIVE_ID = out_var_PRIMITIVE_ID;
    stage_output.out_var_VELOCITY_PREV_POS = out_var_VELOCITY_PREV_POS;
    return stage_output;
}
