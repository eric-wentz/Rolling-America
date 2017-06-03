Function Add-TextToImage {
    # Orignal code from http://www.ravichaganti.com/blog/?p=1012
    [CmdletBinding()]
    PARAM (
        [Parameter(Mandatory=$true)][String] $xCoord,
        [Parameter(Mandatory=$true)][String] $yCoord,
        [Parameter(Mandatory=$true)][String] $sourcePath,
        [Parameter(Mandatory=$true)][String] $destPath,
        [Parameter(Mandatory=$true)][String] $Title
    )
 
    Write-Verbose "Load System.Drawing"
    [Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
     
    Write-Verbose "Get the image from $sourcePath"
    $srcImg = [System.Drawing.Image]::FromFile($sourcePath)
     
    Write-Verbose "Create a bitmap as $destPath"
    $bmpFile = new-object System.Drawing.Bitmap([int]($srcImg.width)),([int]($srcImg.height))
 
    Write-Verbose "Intialize Graphics"
    $Image = [System.Drawing.Graphics]::FromImage($bmpFile)
    $Image.SmoothingMode = "AntiAlias"
     
    $Rectangle = New-Object Drawing.Rectangle 0, 0, $srcImg.Width, $srcImg.Height
    $Image.DrawImage($srcImg, $Rectangle, 0, 0, $srcImg.Width, $srcImg.Height, ([Drawing.GraphicsUnit]::Pixel))
 
    Write-Verbose "Draw title: $Title"
    $Font = new-object System.Drawing.Font("Verdana", 14)
    $Brush = New-Object Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 0, 0,0))
    $Image.DrawString($Title, $Font, $Brush, $xCoord, $yCoord)
     

 
    Write-Verbose "Save and close the files"
    $bmpFile.save($destPath, [System.Drawing.Imaging.ImageFormat]::Bmp)
    $bmpFile.Dispose()
    $srcImg.Dispose()
}
Copy-Item .\Desktop\RollingAmerica.jpg -Destination .\Desktop\RollingAmerica2.jpg
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "1" -xCoord 500 -yCoord 60
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "2" -xCoord 473 -yCoord 80
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "3" -xCoord 453 -yCoord 80
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "4" -xCoord 425 -yCoord 115
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "5" -xCoord 470 -yCoord 108
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "6" -xCoord 460 -yCoord 127
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "7" -xCoord 490 -yCoord 127
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "8" -xCoord 453 -yCoord 147
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "9" -xCoord 453 -yCoord 165
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "10" -xCoord 393 -yCoord 158
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "11" -xCoord 350 -yCoord 158
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "12" -xCoord 425 -yCoord 186
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "13" -xCoord 393 -yCoord 200
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "14" -xCoord 360 -yCoord 186
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "15" -xCoord 393 -yCoord 223
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
add-texttoimage -sourcePath .\Desktop\RollingAmerica2.jpg -destPath .\Desktop\RollingAmerica3.jpg -Title "16" -xCoord 393 -yCoord 247
Move-Item .\Desktop\RollingAmerica3.jpg -Destination .\Desktop\RollingAmerica2.jpg -Force
Invoke-Item .\Desktop\RollingAmerica2.jpg