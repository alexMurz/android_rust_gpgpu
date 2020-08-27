#version 450

layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;


layout(set = 0, binding = 0) buffer Data {
    float data[];
} data;

layout(push_constant) uniform PushData {
    uint origin;
} push;


void main() {
    uint idx = gl_GlobalInvocationID.x + push.origin;
    float v = data.data[idx];
    data.data[idx] = 2.0*sin(v) - cos(2.0*v);
}