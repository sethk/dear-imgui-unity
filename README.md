# Dear ImGui for Unity - ImGUI v1.84.1

UPM package for the immediate mode GUI library, Dear ImGui (https://github.com/ocornut/imgui).

### Usage

- [Add package](https://docs.unity3d.com/Manual/upm-ui-giturl.html) from git URL: https://github.com/GuybrushThreepwood-GitHub/dear-imgui-unity  #_version_branch_ (e.g. https://github.com/GuybrushThreepwood-GitHub/dear-imgui-unity#v1.84.1 )
- Add a `DearImGui` component to one of the objects in the scene.
- When using the **Universal Render Pipeline**
  * add a `Render Im Gui Feature` render feature to the renderer asset. 
  * Assign it to the `render feature` field of the DearImGui component.
- When using the **HDRP Render Pipeline** 
  * add a Custom Pass Volume component. 
  * set the Injection Point to 'After Post Process'.
  * Now add a pass 'DrawRenderersCustomPass' and name it 'PreDraw'.
  * Add another pass 'ImGuiRendererHDRPPass' and name it 'DrawDearImGUI'.

![image](https://user-images.githubusercontent.com/2954404/143776024-718846dc-df6d-4845-96f1-6fefab1f40f9.png)

- Subscribe to the `ImGuiUn.Layout` event and use ImGui functions.
- Example script:
  ```cs
  using UnityEngine;
  using ImGuiNET;

  public class DearImGuiDemo : MonoBehaviour
  {
      void OnEnable()
      {
          ImGuiUn.Layout += OnLayout;
      }

      void OnDisable()
      {
          ImGuiUn.Layout -= OnLayout;
      }

      void OnLayout()
      {
          ImGui.ShowDemoWindow();
      }
  }
  ```
### Supported platforms
- Windows (64 bit only)
- MacOS
- Linux
- Android
- TODO: iOS (maybe)

### See Also

This package uses Dear ImGui C bindings by [cimgui](https://github.com/cimgui/cimgui) and the C# wrapper by [ImGui.NET](https://github.com/mellinoe/ImGui.NET).

The development project for the package can be found at https://github.com/GuybrushThreepwood-GitHub/dear-imgui-unity-dev (forked from: https://github.com/realgamessoftware/dear-imgui-unity-dev ) .
