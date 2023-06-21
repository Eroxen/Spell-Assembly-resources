#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;



void main() {
    // vanilla behavior
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;



    // reposition text from outside screen
    if (gl_Position.x > 1.0)
    {
        // set shadow alpha to 0
        if (gl_Position.z == 0)
            vertexColor.a = 0;

        // title
        if (gl_Position.y > -0.2 && gl_Position.y < 0.5)
        {
            if (gl_Position.x > 8.55)
                gl_Position.x -= 1.0;

            gl_Position.w *= 1.1;
            gl_Position.x -= 8.0;
        }

        // actionbar
        if (gl_Position.y > -0.6 && gl_Position.y < -0.3)
            gl_Position.x -= 0.5;
    }

}