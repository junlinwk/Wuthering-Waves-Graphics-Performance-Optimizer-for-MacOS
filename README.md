# Wuthering Waves Graphics & Performance Optimizer for MacOS (Hardware-Aware Edition) 
# 《鳴潮》MacOS 光追畫質與效能優化工具（硬體自適應）

<p align="center">
  <img src="https://github.com/user-attachments/assets/72849e99-66f4-4745-af17-cf3a93ddc7df" width="30%" alt="Wuwa logo">
</p>

An optimization tool designed to bridge the gap between macOS and high-end PC gaming performance for Wuthering Waves. By leveraging hardware-aware configuration injection, this tool restores ray-tracing-like lighting effects, optimizes dynamic draw distances, and provides granular control over render resolution scaling to maximize visual fidelity and system stability.<br>

本工具旨在縮短 macOS 與高端 PC 遊戲效能之間的差距。透過硬體感知配置注入技術，本工具成功還原了類光線追蹤的光影細節，並針對動態渲染距離與畫面渲染比例進行深度優化，在大幅提升視覺品質的同時確保系統運行之穩定性。

---

## Language / 語言
- [English](#features)
- [繁體中文](#主要功能)

---
## Visual Quality Enhancement Comparison / 視覺品質增強對比
> **Note:** Click the image to view in high resolution.<br>
> **提示：** 點擊圖片以檢視高解析度原圖

| Before (Original) | After (Optimized) |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/671b9451-fd50-40cb-b48a-51efac733ea2" width="450" alt="Before Optimization" /> | <img src="https://github.com/user-attachments/assets/7904917d-999d-4d16-af67-1df2c9134eda" width="450" alt="After Optimization" /> |
| *Native Highest Preset with limited Screen Space Reflections (SSR).* | *Enhanced shadows, XeGTAO, and ray-tracing-like lighting effects.* |
| **Notice:** Flat water surface with minimal detail. | **Focus:** Enhanced **Screen Space Reflections (SSR)** and depth in the pool. |
| **注意：** 水面缺乏反射細節 |  大幅增強**水潭倒影 (SSR)** 與視覺深度 |

## Features

* **Visual Fidelity and Lighting Restoration**: Restores and enhances high-end PC lighting effects and ray-tracing-like shadows, delivering a more realistic and layered visual experience on macOS.
* **Independent Resolution Scaling**: Provides specialized options to adjust the internal 3D render percentage. This allows users to boost FPS significantly while maintaining a sharp, native-resolution UI.
* **Dynamic Draw Distance Optimization**: Significantly improves draw distance for environmental objects and grass foliage, effectively reducing pop-in issues and enhancing overall scene stability.
* **High-End Shadows and Ambient Occlusion**: Enhances grass shadow quality and implements high-quality XeGTAO (Ground Truth Ambient Occlusion) to increase depth and realism between objects and terrains.
* **Adaptive VRAM Pool Management**: Optimizes the Streaming.PoolSize specifically for macOS Unified Memory architecture, eliminating texture blurring and loading stutters caused by default engine constraints.
* **Hardware-Aware Scaling**: Automatically detects system RAM (e.g., 8GB, 16GB, 32GB+) to dynamically calculate the optimal memory pool and view distance parameters for the specific hardware.
* **Metal Performance HUD Integration**: Leverages system-level commands to integrate the macOS Metal Performance HUD, allowing users to toggle real-time telemetry (FPS, GPU usage) with one click.
* **Non-Destructive File Injection**: Precisely target and update the [ConsoleVariables] section in Engine.ini without corrupting other user settings.
* **One-Click Recovery Button**: Features a built-in backup and restore mechanism, allowing users to revert all modifications to the original game state safely.

---
## Installation and Usage

### For General Users
1. Go to the **Releases** page of this repository.
2. Download the latest `Wuthering Waves Optimizer Installer` file.
3. Open the dmg file and move the `Wuthering_Waves_Optimizer.app` to your Applications folder.
4. Launch the application and select your desired optimization level.
5. Tap `allow` after select your optimize plan.

### For Developers and Advanced Users
If you wish to audit the code, modify parameters, or build the application yourself:
1. Download the `WuWa_Optimizer_macOS.applescript` source file from this repository.
2. Open the file using the native macOS **Script Editor** app.
3. (Optional) Review the Zsh logic and hardware-aware scaling constants within the script.
4. To create a standalone app: Select **File > Export...** from the menu.
5. Set **File Format** to **Application** and ensure the "Startup Screen" option is unchecked.
6. Save the exported `.app` and run it to apply your custom configurations.

---

## Feedback and Contributions 

If you encounter any issues or have suggestions for further optimizations (e.g., specific Unreal Engine parameters or hardware scaling logic), please feel free to reach out. Contributions are welcome!

* **Bug Reports**: Please open an **Issue** in this repository.
* **Feature Suggestions**: Feel free to submit a **Pull Request** or start a **Discussion**.
* **Contact Me**: You can reach me directly via email at: `tapjun888@gmail.com`


---

## 主要功能

* **光影效果與細節還原**：還原並增強接近 PC 高端設備的光影效果與光追效果，使場景中的光影細節更加真實且有層次。
* **獨立渲染解析度調整**：提供專門針對渲染百分比的優化選項，讓玩家在保持 UI 清晰度的情況下，透過降低 3D 渲染壓力大幅提升幀數。
* **動態渲染距離優化**：全面改善物件渲染距離與草地細節，有效減少遠處物件突然出現的現象，提升整體視覺穩定性。
* **高階陰影與環境光遮蔽**：增強草地陰影效果，並導入更高品質的環境光遮蔽 (XeGTAO)，顯著提升物件與地面間的立體感與寫實度。
* **自適應顯存池管理**：針對 macOS 統一記憶體架構優化顯存池設定，解決預設設定下可能產生的貼圖模糊或加載延遲問題。
* **智慧硬體感知**：系統會自動偵測 Mac 實體記憶體總量，並據此動態計算最適合該硬體的顯存上限與視距參數。
* **Metal Performance HUD 整合**：透過系統底層指令整合 macOS 專屬的 Metal 效能監測工具，支援一鍵開啟或關閉即時效能數據面板。
* **非破壞性檔案修改**：精確鎖定並更新 Engine.ini 區塊，確保不損毀使用者的其他個人化設定。
* **一鍵還原鍵**：內建備份與還原機制，可隨時將所有修改重置回遊戲原始預設狀態，安全且無副作用。

---
## 安裝與使用指南

### 一般使用者
1. 前往本專案的 **Releases** 頁面。
2. 下載最新的 `Wuthering Waves Optimizer Installer.dmg` 檔案。
3. 開啟dmg檔案後，將 `Wuthering_Waves_Optimizer.app` 移動至您的「應用程式」資料夾。
4. 啟動應用程式並選擇您想要的優化方案。
5. 當 macOS 彈出資料夾存取權限請求時，請點擊**「允許」**以利腳本修改設定檔。

### 開發者
1. 下載本專案中的 `WuWa_Optimizer_macOS.applescript` 原始碼。
2. 使用 macOS 內建的「指令碼編輯器」開啟。
3. 您可以審核其中的 Zsh 邏輯與硬體感知縮放參數。
4. 如需自行封裝：選擇選單中的「檔案 > 輸出...」，將「檔案格式」設定為「應用程式」。
5. 執行該應用程式，選擇方案後並點擊「允許」存取權限。

---
##  聯絡與改進建議
如果您在使用過程中遇到任何問題，或有更好的優化建議（例如特定的虛幻引擎參數或硬體縮放邏輯），歡迎隨時與我聯繫。非常歡迎任何形式的貢獻！
* **錯誤回報**：請在本專案中提交 **Issue**。
* **功能建議**：歡迎提交 **Pull Request** 或發起 **Discussion** 討論。
* **聯絡我**：您可以直接透過電子郵件與我聯繫：`tapjun888@gmail.com`
---

## License
Distributed under the MIT License. See LICENSE for more information.
