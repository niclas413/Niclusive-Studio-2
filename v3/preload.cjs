const { contextBridge } = require("electron");
contextBridge.exposeInMainWorld("niclusiveDesktop", Object.freeze({
  version: "3.0.0",
  platform: process.platform
}));
