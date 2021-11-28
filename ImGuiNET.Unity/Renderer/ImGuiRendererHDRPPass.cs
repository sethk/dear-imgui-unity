#if HAS_HDRP
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.Rendering;

using ImGuiNET.Unity;

class ImGuiRendererHDRPPass : CustomPass
{
	private DearImGui[] dearImGuis;

    // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
    // When empty this render pass will render to the active camera render target.
    // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
    // The render pipeline will ensure target setup and clearing happens in an performance manner.
    protected override void Setup(ScriptableRenderContext renderContext, CommandBuffer cmd)
    {
		dearImGuis = GameObject.FindObjectsOfType<DearImGui>();
    }

    protected override void Execute(ScriptableRenderContext renderContext, CommandBuffer cmd, HDCamera hdCamera, CullingResults cullingResult)
    {
		// Executed every frame for all the camera inside the pass volume

		foreach (DearImGui imgui in dearImGuis)
		{
            CommandBuffer cb = imgui.GetCommandBuffer();

            if (cb == null) 
                return;

            renderContext.ExecuteCommandBuffer(cb);
			renderContext.Submit();
		}
    }

    protected override void Cleanup()
    {
        // Command buffer will be cleaned by the DearImGui class
    }
}
#endif