# PowerShell script to run Flutter with filtered output
# Usage: .\run_flutter_clean.ps1

param(
    [string]$Command = "run"
)

Write-Host "🚀 Running Flutter with filtered output..." -ForegroundColor Green
Write-Host "📱 This will hide buffer warnings and show only important messages" -ForegroundColor Yellow

# Define patterns to filter out
$FilterPatterns = @(
    "ImageReader_JNI",
    "Unable to acquire a buffer item",
    "very likely client tried to acquire more than maxImages buffers",
    "BufferPoolAccessor2.0",
    "EGL_emulation",
    "app_time_stats",
    "CCodec",
    "CCodecConfig", 
    "MediaCodec",
    "Surface",
    "Codec2",
    "ReflectedParamUpdater",
    "onInputBufferReleased",
    "Suspending all threads",
    "Background concurrent mark compact GC"
)

# Run flutter command and filter output
flutter $Command --hot | ForEach-Object {
    $line = $_
    $shouldShow = $true
    
    foreach ($pattern in $FilterPatterns) {
        if ($line -match $pattern) {
            $shouldShow = $false
            break
        }
    }
    
    if ($shouldShow) {
        # Color code important messages
        if ($line -match "error|Error|ERROR") {
            Write-Host $line -ForegroundColor Red
        }
        elseif ($line -match "warning|Warning|WARNING") {
            Write-Host $line -ForegroundColor Yellow
        }
        elseif ($line -match "Built|Installing|Launching") {
            Write-Host $line -ForegroundColor Green
        }
        elseif ($line -match "Hot reload|Hot restart") {
            Write-Host $line -ForegroundColor Cyan
        }
        else {
            Write-Host $line
        }
    }
}

Write-Host "`n✅ Flutter session ended" -ForegroundColor Green
