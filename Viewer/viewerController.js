document.addEventListener("DOMContentLoaded", () => {
  const viewer = document.getElementById("jewelryViewer");

  function loadModel(src) {
    viewer.src = src;
  }

  function resetCamera() {
    viewer.cameraOrbit = "auto auto auto";
  }

  function setCanPan(enabled) {
    viewer.interactionPrompt = enabled ? "pan" : "";
  }

  function setCanZoom(enabled) {
    viewer.disableZoom = !enabled;
  }

  function setCanRotate(enabled) {
    viewer.interactionPrompt = enabled ? "rotate" : "";
  }

  function setIsAutoRotate(enabled) {
    viewer.autoRotate = enabled;
  }

  function setBackgroundColor(color) {
    viewer.backgroundColor = color;
  }

  // Example usage:
  //   loadModel("path/to/your/model.glb");
  //   resetCamera();
  //   setCanPan(true);
  //   setCanZoom(true);
  //   setCanRotate(true);
  //   setIsAutoRotate(false);
  //   setBackgroundColor("#ffffff");
});
