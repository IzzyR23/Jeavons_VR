#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    uint View_View_InstanceSceneDataSOAStride : packoffset(c283);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_InstanceSceneData;
ByteAddressBuffer InstanceCulling_InstanceIdsBuffer;
cbuffer LocalVF
{
    int4 LocalVF_LocalVF_VertexFetch_Parameters : packoffset(c0);
};

Buffer<float4> LocalVF_VertexFetch_PackedTangentsBuffer;

static float4 gl_Position;
static int gl_VertexIndex;
static int gl_InstanceIndex;
static float4 in_var_ATTRIBUTE0;
static uint in_var_ATTRIBUTE13;
static float4 out_var_TEXCOORD10_centroid;
static float4 out_var_TEXCOORD11_centroid;
static uint out_var_PRIMITIVE_ID;

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
    nointerpolation uint out_var_PRIMITIVE_ID : PRIMITIVE_ID;
    precise float4 gl_Position : SV_Position;
};

static float3x3 _91 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);

void vert_main()
{
    float3 _103 = -View_View_ViewTilePosition;
    uint _122 = 0u;
    if ((in_var_ATTRIBUTE13 & 2147483648u) != 0u)
    {
        _122 = uint(int(asuint(asfloat(View_PrimitiveSceneData.Load4(((in_var_ATTRIBUTE13 & 2147483647u) * 42u) * 16 + 0)).y))) + uint(gl_InstanceIndex);
    }
    else
    {
        _122 = InstanceCulling_InstanceIdsBuffer.Load((in_var_ATTRIBUTE13 + uint(gl_InstanceIndex)) * 4 + 0) & 268435455u;
    }
    uint _128 = asuint(asfloat(View_InstanceSceneData.Load4(_122 * 16 + 0)).x);
    uint _130 = (_128 >> 0u) & 1048575u;
    float3 _245 = 0.0f.xxx;
    float4x4 _246 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float3 _247 = 0.0f.xxx;
    float _248 = 0.0f;
    [branch]
    if (false || (_130 != 1048575u))
    {
        uint4 _145 = asuint(asfloat(View_InstanceSceneData.Load4((View_View_InstanceSceneDataSOAStride + _122) * 16 + 0)));
        uint _147 = (2u * View_View_InstanceSceneDataSOAStride) + _122;
        float4x4 _151 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _151[3] = float4(asfloat(View_InstanceSceneData.Load4(_147 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_147 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_147 * 16 + 0)).z, 0.0f.xxxx.w);
        float4x4 _152 = _151;
        _152[3].w = 1.0f;
        uint _153 = _145.x;
        uint _160 = _145.y;
        float _163 = float((_160 >> 0u) & 32767u);
        float2 _167 = (float3(float((_153 >> 0u) & 65535u), float((_153 >> 16u) & 65535u), _163).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _169 = (_163 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
        bool _171 = (_160 & 32768u) != 0u;
        float _172 = _167.x;
        float _173 = _167.y;
        float _174 = _172 + _173;
        float _175 = _172 - _173;
        float3 _181 = normalize(float3(_174, _175, 2.0f - dot(1.0f.xx, abs(float2(_174, _175)))));
        float4 _182 = float4(_181.x, _181.y, _181.z, 0.0f.xxxx.w);
        float4x4 _183 = _152;
        _183[2] = _182;
        float _186 = 1.0f / (1.0f + _181.z);
        float _187 = _181.x;
        float _188 = -_187;
        float _189 = _181.y;
        float _191 = (_188 * _189) * _186;
        float _203 = sqrt(1.0f - (_169 * _169));
        float3 _208 = (float3(1.0f - ((_187 * _187) * _186), _191, _188) * (_171 ? _169 : _203)) + (float3(_191, 1.0f - ((_189 * _189) * _186), -_189) * (_171 ? _203 : _169));
        float4 _209 = float4(_208.x, _208.y, _208.z, 0.0f.xxxx.w);
        float4x4 _210 = _183;
        _210[0] = _209;
        float3 _213 = cross(_181.xyz, _208.xyz);
        float4 _214 = float4(_213.x, _213.y, _213.z, 0.0f.xxxx.w);
        float4x4 _215 = _210;
        _215[1] = _214;
        uint _216 = _145.w;
        uint _221 = _145.z;
        float3 _229 = (float3(uint3(_221 >> 0u, _221 >> 16u, _216 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_216 >> 16u) - 15u) << 23u);
        float4x4 _232 = _215;
        _232[0] = _209 * _229.x;
        float4x4 _235 = _232;
        _235[1] = _214 * _229.y;
        float4x4 _238 = _235;
        _238[2] = _182 * _229.z;
        _245 = 1.0f.xxx / abs(_229).xyz;
        _246 = _238;
        _247 = asfloat(View_PrimitiveSceneData.Load4(((_130 * 42u) + 1u) * 16 + 0)).xyz;
        _248 = ((((_128 >> 20u) & 4095u) & 1u) != 0u) ? (-1.0f) : 1.0f;
    }
    else
    {
        _245 = 0.0f.xxx;
        _246 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _247 = 0.0f.xxx;
        _248 = 0.0f;
    }
    uint _253 = 2u * (uint(LocalVF_LocalVF_VertexFetch_Parameters.w) + uint(gl_VertexIndex));
    float4 _258 = LocalVF_VertexFetch_PackedTangentsBuffer.Load(_253 + 1u);
    float _259 = _258.w;
    float3 _260 = _258.xyz;
    float3 _262 = cross(_260, LocalVF_VertexFetch_PackedTangentsBuffer.Load(_253).xyz) * _259;
    float3x3 _265 = _91;
    _265[0] = cross(_262, _260) * _259;
    float3x3 _266 = _265;
    _266[1] = _262;
    float3x3 _267 = _266;
    _267[2] = _260;
    float3x3 _277 = float3x3(_246[0].xyz, _246[1].xyz, _246[2].xyz);
    _277[0] = _246[0].xyz * _245.x;
    float3x3 _280 = _277;
    _280[1] = _246[1].xyz * _245.y;
    float3x3 _283 = _280;
    _283[2] = _246[2].xyz * _245.z;
    float3x3 _284 = mul(_267, _283);
    float3 _287 = in_var_ATTRIBUTE0.xxx * _246[0].xyz;
    float3 _289 = in_var_ATTRIBUTE0.yyy * _246[1].xyz;
    float3 _290 = _287 + _289;
    float3 _292 = in_var_ATTRIBUTE0.zzz * _246[2].xyz;
    float3 _293 = _290 + _292;
    float3 _296 = _247 + _103;
    float3 _297 = _246[3].xyz + View_View_RelativePreViewTranslation;
    float3 _298 = _296 * 2097152.0f;
    float3 _299 = _298 + _297;
    float3 _300 = _293 + _299;
    float _301 = _300.x;
    float _302 = _300.y;
    float _303 = _300.z;
    float4 _304 = float4(_301, _302, _303, 1.0f);
    float4 _305 = mul(_304, View_View_TranslatedWorldToClip);
    out_var_TEXCOORD10_centroid = float4(_284[0], 0.0f);
    out_var_TEXCOORD11_centroid = float4(_284[2], _259 * _248);
    out_var_PRIMITIVE_ID = _130;
    gl_Position = _305;
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
    stage_output.out_var_PRIMITIVE_ID = out_var_PRIMITIVE_ID;
    return stage_output;
}
