Add-Type -AssemblyName System.Drawing

$width = 1080
$height = 1920
$bgImage = [System.Drawing.Image]::FromFile("c:\Users\user\genesis-gallery\landing-bg.png")

$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Draw background (scale to cover properly, center crop if needed)
$ratioX = $width / $bgImage.Width
$ratioY = $height / $bgImage.Height
$ratio = [math]::Max($ratioX, $ratioY)

$newWidth = [int]($bgImage.Width * $ratio)
$newHeight = [int]($bgImage.Height * $ratio)
$posX = [int](($width - $newWidth) / 2)
$posY = [int](($height - $newHeight) / 2)

$g.DrawImage($bgImage, $posX, $posY, $newWidth, $newHeight)

# Add a dark overlay so text is readable
$overlayBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(100, 0, 0, 0))
$g.FillRectangle($overlayBrush, 0, 0, $width, $height)

# Fonts
$fontTitle = New-Object System.Drawing.Font("Arial", 50, [System.Drawing.FontStyle]::Bold)
$fontSub = New-Object System.Drawing.Font("Arial", 30, [System.Drawing.FontStyle]::Regular)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$brushGold = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 234, 179, 8))

# Draw Text
$title = "RITUAL GENESIS GALLERY"
$sub = "Showcase your Genesis Card On-Chain"
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center

$rectTitle = New-Object System.Drawing.RectangleF(0, 150, $width, 100)
$rectSub = New-Object System.Drawing.RectangleF(0, 240, $width, 100)

$g.DrawString($title, $fontTitle, $brushGold, $rectTitle, $sf)
$g.DrawString($sub, $fontSub, $brush, $rectSub, $sf)

$bmp.Save("c:\Users\user\genesis-gallery\twitter-poster.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)

$g.Dispose()
$bmp.Dispose()
$bgImage.Dispose()
$overlayBrush.Dispose()
$brush.Dispose()
$brushGold.Dispose()

Write-Host "Generated twitter-poster.jpg"
