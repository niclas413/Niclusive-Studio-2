const { app, BrowserWindow, shell } = require("electron");
const path = require("node:path");
const fs = require("node:fs");

function configurePortableStorage() {
  // electron-builder's portable launcher provides PORTABLE_EXECUTABLE_DIR.
  // Fall back to the executable directory for unpacked development builds.
  const portableDir = process.env.PORTABLE_EXECUTABLE_DIR || path.dirname(process.execPath);
  const dataDir = path.join(portableDir, "Niclusive Music Studio Data");
  try {
    fs.mkdirSync(dataDir, { recursive: true });
    app.setPath("userData", dataDir);
    app.setPath("sessionData", path.join(dataDir, "Session"));
  } catch (error) {
    // If the executable folder is read-only (e.g. protected Program Files),
    // keep Electron's standard userData path rather than failing to launch.
    console.error("Portable data directory unavailable; using Electron default:", error);
  }
}

configurePortableStorage();

function createWindow() {
  const win = new BrowserWindow({
    width: 1440,
    height: 920,
    minWidth: 1080,
    minHeight: 700,
    backgroundColor: "#101317",
    title: "Niclusive Music Studio 3.0",
    webPreferences: {
      preload: path.join(__dirname, "preload.cjs"),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true
    }
  });
  win.loadFile(path.join(__dirname, "renderer", "index.html"));
  win.webContents.setWindowOpenHandler(({ url }) => {
    if (url.startsWith("https://")) shell.openExternal(url);
    return { action: "deny" };
  });
}
app.whenReady().then(() => {
  createWindow();
  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});
app.on("window-all-closed", () => {
  if (process.platform !== "darwin") app.quit();
});
