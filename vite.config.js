import { defineConfig } from "vite";

export default defineConfig({
  root: "public",
  server: {
    // open in browser on start (keeps current behavior) and expose on LAN so
    // a VR-bril op hetzelfde netwerk kan verbinden (via http://<PC-IP>:5173).
    open: true,
    host: true,
    // If needed, you can enable https here by providing key/cert. For local
    // headset testing it's often easier to use adb reverse or browse to
    // localhost on the device.
    // https: false,
  },
  optimizeDeps: {
    include: ["aframe"],
  },
});
