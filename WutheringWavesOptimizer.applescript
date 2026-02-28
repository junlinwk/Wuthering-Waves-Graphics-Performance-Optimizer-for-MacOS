# ==========================================================
# Title: Wuthering Waves Optimizer for macOS (Auto Adaptive)
# Description: Dynamic Engine.ini optimization based on Hardware RAM
# Author: junlinwk
# Features: Hardware detection, Dynamic PoolSize, Scaling Render Distance
# ==========================================================

on run {input, parameters}
	set menuOptions to {"Level 5: Godly", "Level 4: Cinema", "Level 3: Daily", "Level 2: Combat", "Level 1: Extreme Speed", "Default (75%)", "Metal HUD: ON", "Metal HUD: OFF", "Reset to Default"}
	
	set chosenItems to (choose from list menuOptions with title "Wuthering Waves Optimizer" with prompt "The script will automatically scale settings based on your RAM:" default items {"Level 3: Daily"})
	
	if chosenItems is false then return
	
	set chosenItem to item 1 of chosenItems
	
	set levelArg to "0"
	if chosenItem contains "Level 5" then
		set levelArg to "5"
	else if chosenItem contains "Level 4" then
		set levelArg to "4"
	else if chosenItem contains "Level 3" then
		set levelArg to "3"
	else if chosenItem contains "Level 2" then
		set levelArg to "2"
	else if chosenItem contains "Level 1" then
		set levelArg to "1"
	else if chosenItem contains "Default (75%)" then
		set levelArg to "LD"
	else if chosenItem contains "ON" then
		set levelArg to "-2"
	else if chosenItem contains "OFF" then
		set levelArg to "-1"
	end if
	
	try
		do shell script "zsh <<'EOF'
# Target configuration file path
FILE=\"$HOME/Library/Containers/com.kurogame.wutheringwaves.global/Data/Library/Preferences/Client/MacNoEditor/Engine.ini\"
LEVEL=" & levelArg & "

# Verify existence of the configuration file
if [[ ! -f \"$FILE\" ]]; then
    echo \"Configuration file not found.\" >&2
    exit 1
fi

# ==========================================
# NEW: Hardware Detection & Dynamic Scaling
# ==========================================
RAM_GB=$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))

# Define Base Values (Scale based on 16GB baseline)
if (( RAM_GB >= 31 )); then
    # 32GB+ RAM: Ultra Scaling
    BASE_PS=24000; BASE_G_CULL=30000; BASE_NPC_DIST=30000; BASE_V_DIST=4.0
elif (( RAM_GB >= 15 )); then
    # 16GB/18GB/24GB RAM: Standard Baseline (Your original version)
    BASE_PS=12000; BASE_G_CULL=20000; BASE_NPC_DIST=20000; BASE_V_DIST=3.0
else
    # 8GB/12GB RAM: Safety Scaling
    BASE_PS=4000; BASE_G_CULL=10000; BASE_NPC_DIST=10000; BASE_V_DIST=1.5
fi

# 1. Clean up existing [ConsoleVariables] block
awk '
    /^\\[ConsoleVariables\\]/ { skip=1; next }
    /^\\[/ { skip=0 }
    !skip { print }
' \"$FILE\" > \"${FILE}.tmp\"

# 2. Handle Metal Performance HUD
if [[ \"$LEVEL\" == \"-2\" ]]; then
    launchctl setenv MTL_HUD_ENABLED 1
    mv \"${FILE}.tmp\" \"$FILE\"
    exit 0
elif [[ \"$LEVEL\" == \"-1\" ]]; then
    launchctl setenv MTL_HUD_ENABLED 0
    mv \"${FILE}.tmp\" \"$FILE\"
    exit 0
fi

# 3. Handle Reset to Default
if [[ \"$LEVEL\" == \"0\" ]]; then
    mv \"${FILE}.tmp\" \"$FILE\"
    exit 0
fi

# 4. Define optimization templates with Dynamic Variables
if [[ \"$LEVEL\" == \"LD\" ]]; then
    CONTENT=\"r.DynamicRes.OperationMode=0\\nr.SecondaryScreenPercentage.GameViewport=75\\nr.Editor.ScreenPercentageMode=0\"
else
    # Use Dynamic values for Level 5 template
    read -r -d '' CONTENT <<INNER_EOF
r.DynamicRes.OperationMode=0
r.SecondaryScreenPercentage.GameViewport=100
r.Editor.ScreenPercentageMode=0
r.SSGI.Enable=0
r.SSGI.Quality=3
r.SSR.Quality=4
r.SSR.Temporal=1
r.SSR.MaxRoughness=0.6
r.SSR.HalfResSceneColor=0
FX.BatchAsync=1
FX.EarlyScheduleAsync=1
tick.AllowAsyncTickCleanup=1
tick.AllowAsyncTickDispatch=1
s.AsyncLoadingThreadEnabled=1
s.EventDrivenLoaderEnabled=1
r.Streaming.AmortizeCPUWork=1
r.Streaming.MaxQueuedReads=128
r.Color.Max=1.1
r.Color.Mid=0.55
r.Color.Min=0.0
r.KuroTonemapping=1
r.TonemapperFilm=0
r.Client.Contrast=1.0
r.Client.Saturation=1.0
r.DOF.Gather.AccumulatorQuality=1
r.DOF.Gather.PostfilterMethod=1
r.DOF.Gather.RingCount=4
r.DOF.Recombine.Quality=1
r.Shadow.RadiusThreshold=0.016
r.Shadow.RadiusThresholdOverrideEnable=1
r.Shadow.MaxCSMResolution=2048
r.Shadow.MinResolution=2048
r.Shadow.PerObjectShadowMapResolution=2048
r.Shadow.PerObjectResolutionMax=2048
r.Shadow.PerObjectResolutionMin=2048
r.Shadow.CSM3ShadowPCFQuality=3
r.Shadow.CSMUsePCHighConfig=1
r.Kuro.FlickerLightActorTickFactor=2.4
r.ContactShadows.NonShadowCastingIntensity=0.65
r.Shadow.Denoiser=1
r.AmbientOcclusion.Method=2
r.XeGTAO.Quality=3
r.XeGTAO.Radius=200
r.XeGTAO.UseHzb=1
r.XeGTAO.Denoise=1
r.XeGTAO.FalloffRange=0.615
r.XeGTAO.UseHilbertLUT=1
r.XeGTAO.UseSceneNormal=1
r.XeGTAO.FinalValuePower=1.1
r.XeGTAO.SampleDistributionPower=1.5
r.AmbientOcclusion.Power=1.1
r.AmbientOcclusionMaxQuality=100
r.AmbientOcclusion.HalfRes=0
r.AmbientOcclusion.Radius=120
r.AmbientOcclusion.HalfResUpsample=0
niagara.CreateShadersOnLoad=1
r.Kuro.InteractionEffect.UseCppWaterEffect=1
a.URO.ForceAnimRate=1
r.SSFS=0
r.SSFS.PassAmount=9
r.StaticMeshLODDistanceScale=0.4
r.ViewTextureMipBias.Min=-1.0
r.ViewTextureMipBias.Offset=-1
r.BBM.BoundsScale=1.0
r.Kuro.SkeletalMesh.LODDistanceScale=1.0
r.ScreenSizeCullRatioFactor=1
r.Streaming.FullyLoadUsedTextures=0
r.Streaming.HLODStrategy=0
r.MaterialQualityLevel=1
r.KuroMaterialQualityLevel=1
r.Streaming.Boost=4.0
r.ViewDistanceScale=$BASE_V_DIST
foliage.LODDistanceScale=2.0
foliage.DensityType=2
r.DetailMode=2
r.Kuro.Foliage.GrassCullDistanceMax=$BASE_G_CULL
r.Kuro.NpcDisappearDistance=$BASE_NPC_DIST
wp.Runtime.SoraGridBlackListHeight=30000
r.MaxAnisotropy=16
r.Kuro.Foliage.PhysicsSimulation=1
r.Streaming.PoolSize=$BASE_PS
r.Streaming.LimitPoolSizeToVRAM=1
INNER_EOF
fi

# 5. Reconstruct Engine.ini
{
    cat \"${FILE}.tmp\"
    echo \"\\n[ConsoleVariables]\"
    echo \"$CONTENT\"
} > \"$FILE\"
rm \"${FILE}.tmp\"

# 6. Apply dynamic overrides (Tiered Scaling)
override() { sed -i '' \"s/^r.$1=.*/r.$1=$2/\" \"$FILE\"; }

# Calculate tiered values based on Base
PS4=$((BASE_PS * 75 / 100)); PS3=$((BASE_PS * 50 / 100)); PS2=$((BASE_PS * 33 / 100)); PS1=$((BASE_PS * 16 / 100))
GC4=$((BASE_G_CULL * 75 / 100)); GC3=$((BASE_G_CULL * 50 / 100)); GC2=$((BASE_G_CULL * 40 / 100)); GC1=$((BASE_G_CULL * 25 / 100))

case $LEVEL in
    4)
        override \"XeGTAO.Quality\" \"2\"; override \"Shadow.MaxCSMResolution\" \"1536\"
        override \"Kuro.Foliage.GrassCullDistanceMax\" \"$GC4\"; override \"Streaming.PoolSize\" \"$PS4\"
        override \"ViewDistanceScale\" \"$(printf \"%.1f\" $((BASE_V_DIST * 0.8)))\"
        ;;
    3)
        override \"XeGTAO.Quality\" \"2\"; override \"Shadow.MaxCSMResolution\" \"1024\"
        override \"Kuro.Foliage.GrassCullDistanceMax\" \"$GC3\"; override \"Streaming.PoolSize\" \"$PS3\"
        override \"ViewDistanceScale\" \"$(printf \"%.1f\" $((BASE_V_DIST * 0.5)))\"
        ;;
    2)
        override \"SecondaryScreenPercentage.GameViewport\" \"85\"
        override \"Streaming.PoolSize\" \"$PS2\"; override \"Kuro.Foliage.GrassCullDistanceMax\" \"$GC2\"
        override \"ViewDistanceScale\" \"$(printf \"%.1f\" $((BASE_V_DIST * 0.33)))\"
        ;;
    1)
        override \"SecondaryScreenPercentage.GameViewport\" \"75\"
        override \"Streaming.PoolSize\" \"$PS1\"; override \"Kuro.Foliage.GrassCullDistanceMax\" \"$GC1\"
        override \"ViewDistanceScale\" \"$(printf \"%.1f\" $((BASE_V_DIST * 0.25)))\"
        ;;
esac
EOF"
		display dialog "Optimization applied successfully!" & return & "Hardware-aware settings synchronized." buttons {"Confirm"} default button "Confirm" with icon note
		
	on error errMsg
		display dialog "Update Failed!" & return & return & errMsg buttons {"Close"} default button "Close" with icon stop
	end try
end run